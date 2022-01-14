# frozen_string_literal: true

require 'better_html'
require 'better_html/parser'

module Erbcop
  # Extract Ruby codes from Erb source.
  class RubyExtractor
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
        clipped = RubyClipper.new(snippet).call
        {
          code: clipped[:code],
          offset: node.location.begin_pos + clipped[:offset]
        }
      end
    end

    private

    # @return [Enumerator<BetterHtml::AST::Node>]
    def nodes
      ::BetterHtml::Parser.new(
        ::Parser::Source::Buffer.new(
          @file_path,
          source: @source
        ),
        template_language: :html
      ).ast.descendants(:code)
    end

    # @return [Array<Array<Integer>>]
    def ranges
      result = []
      traverse(ast) do |begin_, end_|
        result << [begin_, end_]
      end
      result
    end

    def traverse(node, &block)
      return unless node.instance_of?(::Array)

      if node[0] == :erbi && node[1] == :position
        block.call(node[2], node[3])
      else
        node.each do |element|
          traverse(element, &block)
        end
      end
    end
  end
end
