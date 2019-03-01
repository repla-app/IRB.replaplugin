#!/usr/bin/env ruby

require 'test/unit'

require_relative '../bundle/bundler/setup'
require 'repla/test'

require Repla::Test::HELPER_FILE
require Repla::Test::REPLA_FILE

require_relative 'lib/test_constants'

# Test plugin
class TestPlugin < Test::Unit::TestCase
  def setup
    Repla.load_plugin(TEST_PLUGIN_PATH)
  end

  def test_plugin
    Repla.run_plugin(TEST_PLUGIN_NAME, TEST_PLUGIN_PATH)

    window_id = Repla.window_id_for_plugin(TEST_PLUGIN_NAME)
    window = Repla::Window.new(window_id)

    test_code = TEST_CODE.tr("\n", "\uFF00") + "\n"
    window.read_from_standard_input(test_code)
    sleep Repla::Test::TEST_PAUSE_TIME # Pause for output to be processed

    # Test Wrapper Input
    javascript = File.read(Repla::Test::FIRSTCODE_JAVASCRIPT_FILE)
    result = window.do_javascript(javascript)
    result.strip!
    result.gsub!(%r{</?span.*?>}, '') # Remove spans adding by highlight.js
    assert_equal(TEST_CODE, result, 'The test text should equal the result.')

    # Test Wrapper Output
    javascript = File.read(Repla::Test::LASTCODE_JAVASCRIPT_FILE)
    result = window.do_javascript(javascript)
    assert_equal(result, TEST_CODE_RESULT)
  end
end
