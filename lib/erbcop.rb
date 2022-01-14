# frozen_string_literal: true

require_relative 'erbcop/version'

module Erbcop
  autoload :Cli, 'erbcop/cli'
  autoload :Offense, 'erbcop/offense'
  autoload :PathFinder, 'erbcop/path_finder'
  autoload :RuboCopConfigGenerator, 'erbcop/rubo_cop_config_generator'
  autoload :RubyClipper, 'erbcop/ruby_clipper'
  autoload :RubyExtractor, 'erbcop/ruby_extractor'
  autoload :RubyOffenseCollector, 'erbcop/ruby_offense_collector'
  autoload :Runner, 'erbcop/runner'
  autoload :ErbCorrector, 'erbcop/erb_corrector'
  autoload :ErbOffenseCollector, 'erbcop/erb_offense_collector'
end
