#!/usr/bin/env ruby

require 'minitest/autorun'

require_relative '../bundle/bundler/setup'
require 'repla/test'

require Repla::Test::HELPER_FILE
require Repla::Test::REPLA_FILE

require_relative 'lib/test_constants'

# Test plugin
class TestPlugin < Minitest::Test
  def setup
    Repla.load_plugin(TEST_PLUGIN_PATH)
  end

  def test_plugin
    Repla.run_plugin(TEST_PLUGIN_NAME, TEST_PLUGIN_PATH)

    window_id = Repla.window_id_for_plugin(TEST_PLUGIN_NAME)
    window = Repla::Window.new(window_id)

    test_code = TEST_CODE.tr("\n", "\uFF00") + "\n"
    window.read_from_standard_input(test_code)

    # Test Wrapper Input
    javascript = File.read(Repla::Test::FIRSTCODE_JAVASCRIPT_FILE)
    result = nil
    Repla::Test.block_until do
      result = window.do_javascript(javascript)
      !result.nil?
    end
    result.strip!
    # Remove spans added by highlight.js
    result.gsub!(%r{</?span.*?>}, '')
    assert_equal(TEST_CODE, result, 'The test text should equal the result.')

    # Test Wrapper Output
    javascript = File.read(Repla::Test::LASTCODE_JAVASCRIPT_FILE)
    result = window.do_javascript(javascript)
    assert_equal(result, TEST_CODE_RESULT)
    window.close
  end
end
