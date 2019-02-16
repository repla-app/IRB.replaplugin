#!/usr/bin/env ruby

require "test/unit"

require_relative '../bundle/bundler/setup'
require 'repla'

require Repla::shared_test_resource("ruby/test_constants")
require Repla::Tests::TEST_HELPER_FILE

require_relative "lib/test_constants"

class TestPlugin < Test::Unit::TestCase

  def setup
    Repla::load_plugin(TEST_PLUGIN_PATH)
  end

  def teardown
    # window.close
    Repla::Tests::Helper::quit
    Repla::Tests::Helper::confirm_dialog
    assert(!Repla::Tests::Helper::is_running, "The application should not be running.")
  end

  def test_plugin
    Repla::run_plugin(TEST_PLUGIN_NAME, TEST_PLUGIN_PATH)

    window_id = Repla::window_id_for_plugin(TEST_PLUGIN_NAME)
    window = Repla::Window.new(window_id)
    
    test_code = TEST_CODE.gsub("\n", "\uFF00") + "\n"
    window.read_from_standard_input(test_code)
    sleep Repla::Tests::TEST_PAUSE_TIME # Pause for output to be processed

    # Test Wrapper Input
    javascript = File.read(Repla::Tests::FIRSTCODE_JAVASCRIPT_FILE)
    result = window.do_javascript(javascript)
    result.strip!
    result.gsub!(/<\/?span.*?>/, "") # Remove spans adding by highlight.js
    assert_equal(TEST_CODE, result, "The test text should equal the result.")

    # Test Wrapper Output
    javascript = File.read(Repla::Tests::LASTCODE_JAVASCRIPT_FILE)
    result = window.do_javascript(javascript)
    assert_equal(result, TEST_CODE_RESULT, "The test result should equal the result.")
  end

end
