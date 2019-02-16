#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require "test/unit"
require_relative '../bundle/bundler/setup'
require 'repla/test'

require_relative "../lib/view"
require_relative "../lib/output_controller"

class TestOutputController < Test::Unit::TestCase

  def setup
    view = Repla::REPL::IRB::View.new
    @output_controller = Repla::REPL::IRB::OutputController.new(view)
  end
  
  def teardown
    @output_controller.view.close
  end

  def test_output_controller
    test_text = "Some test text"
    @output_controller.parse_output(test_text)
    @output_controller.parse_output("irb(main):001:0> 1 + 1")
    @output_controller.parse_output("irb(main):009:0* 1 + 1")

    javascript = File.read(Repla::Test::LASTCODE_JAVASCRIPT_FILE)
    result = @output_controller.view.do_javascript(javascript)
    result.strip!

    assert_equal(test_text, result, "The test text should equal the result.")
  end

end
