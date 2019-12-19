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
          @mutex = Mutex.new
          super('/usr/bin/ruby --disable-gems /usr/bin/irb')
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
          @mutex.synchronize do
            @view = View.new if @view.nil?
          end
          @view
        end
      end
    end
  end
end
