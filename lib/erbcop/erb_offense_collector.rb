# frozen_string_literal: true

module Erbcop
  # Collect RuboCop offenses from Erb code.
  class ErbOffenseCollector
    # @param [Boolean] auto_correct
    # @param [String] file_path Erb file path
    # @param [RuboCop::Config] rubocop_config
    # @param [String] source Erb code
    def initialize(auto_correct:, file_path:, rubocop_config:, source:)
      @auto_correct = auto_correct
      @file_path = file_path
      @rubocop_config = rubocop_config
      @source = source
    end

    # @return [Array<Erbcop::Offense>]
    def call
      snippets.flat_map do |snippet|
        RubyOffenseCollector.new(
          auto_correct: @auto_correct,
          file_path: @file_path,
          rubocop_config: @rubocop_config,
          source: snippet[:code]
        ).call.map do |rubocop_offense|
          Offense.new(
            file_path: @file_path,
            offset: snippet[:offset],
            rubocop_offense: rubocop_offense,
            source: @source
          )
        end
      end
    end

    private

    # @return [Array<Hash>]
    def snippets
      RubyExtractor.new(
        file_path: @file_path,
        source: @source
      ).call
    end
  end
end
