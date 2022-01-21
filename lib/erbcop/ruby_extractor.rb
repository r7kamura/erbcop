# frozen_string_literal: true

require 'better_html'
require 'better_html/parser'
require 'templatecop'

module Erbcop
  # Extract Ruby codes from Erb source.
  class RubyExtractor
    class << self
      # @param [String, nil] file_path
      # @param [String] source
      def call(
        file_path:,
        source:
      )
        new(
          file_path: file_path,
          source: source
        ).call
      end
    end

    # @param [String, nil] file_path
    # @param [String] source
    def initialize(file_path:, source:)
      @file_path = file_path
      @source = source
    end

    # @return [Array<Hash>]
    def call
      nodes.map do |node|
        snippet = node.children.first
        clipped = ::Templatecop::RubyClipper.new(snippet).call
        {
          code: clipped[:code],
          offset: node.location.begin_pos + clipped[:offset]
        }
      end
    end

    private

    # @return [Array<BetterHtml::AST::Node>]
    def erbs
      root.descendants(:erb).reject do |erb|
        erb.children.first&.type == :indicator && erb.children.first&.to_a&.first == '#'
      end
    end

    # @return [Enumerator<BetterHtml::AST::Node>]
    def nodes
      erbs.flat_map do |erb|
        erb.descendants(:code).to_a
      end
    end

    # @return [BetterHtml::AST::Node]
    def root
      ::BetterHtml::Parser.new(
        ::Parser::Source::Buffer.new(
          @file_path,
          source: @source
        ),
        template_language: :html
      ).ast
    end
  end
end
