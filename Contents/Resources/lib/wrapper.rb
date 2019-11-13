require_relative '../bundle/bundler/setup'
require 'repla/repl'

module Repla
  module REPL
    module IRB
      # Wrapper
      class Wrapper < Repla::REPL::Wrapper
        require_relative 'output_controller'
        require_relative 'view'

        def initialize
          super('/usr/bin/irb')
        end

        def parse_input(input)
          # `\uFF00` is the unicode character Coffee uses for new lines, it's
          # used here just to consolidate code into one line
          input.tr!("\uFF00", "\n")
          super(input)
        end

        def output_controller
          @output_controller ||= OutputController.new(view)
        end

        def view
          @view ||= View.new
        end
      end
    end
  end
end
