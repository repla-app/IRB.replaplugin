require_relative '../bundle/bundler/setup'
require 'repla/repl'

module Repla
  module REPL
    module IRB
      # View
      class View < Repla::REPL::View
        ROOT_ACCESS_DIRECTORY = File.join(File.dirname(__FILE__), '../html')
        VIEW_TEMPLATE = File.join(ROOT_ACCESS_DIRECTORY, 'index.html')

        def initialize
          super
          self.root_access_directory_path = File.expand_path(
            ROOT_ACCESS_DIRECTORY
          )
          load_file(VIEW_TEMPLATE)
        end
      end
    end
  end
end
