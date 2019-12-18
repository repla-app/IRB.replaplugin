require_relative '../bundle/bundler/setup'
require 'repla/repl'

module Repla
  module REPL
    module IRB
      # Output controller
      class OutputController < Repla::REPL::OutputController
        def initialize(view)
          super(view)
          @seen_prompt = false
        end

        def parse_output(output)
          # Suppresss Apple's warning message
          @seen_prompt ||= output =~ /^irb/

          return unless @seen_prompt

          # Don't add echo of input
          return if output =~ /^irb\([^)]*\):[^:]*:[^>]*(>|\*)/

          output = output.dup
          output.sub!(/^=>\s/, '') # Remove output prompt
          super(output)
        end
      end
    end
  end
end
