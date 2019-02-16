require_relative '../bundle/bundler/setup'
require 'repla/repl'

module Repla
  module REPL
    module IRB
      # Output controller
      class OutputController < Repla::REPL::OutputController
        def initialize(view)
          super(view)
          # @SEEN_PROMPT = false
        end

        def parse_output(output)
          # Quick hack to fix a bug where on first run IRB is echoing the input
          # twice
          # if !@SEEN_PROMPT && output =~ /^=>\s/
          #   @SEEN_PROMPT = true
          # else
          #   return
          # end

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
