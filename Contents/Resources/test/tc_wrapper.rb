#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require 'test/unit'

require_relative '../bundle/bundler/setup'
require 'repla/test'

require Repla::Test::HELPER_FILE
require Repla::Test::REPLA_FILE

require_relative 'lib/test_constants'
require_relative '../lib/wrapper'

# Test wrapper
class TestWrapper < Test::Unit::TestCase
  def test_wrapper
    wrapper = Repla::REPL::IRB::Wrapper.new

    test_code = TEST_CODE.tr("\n", "\uFF00") + "\n"
    wrapper.parse_input(test_code)

    sleep Repla::Test::TEST_PAUSE_TIME # Pause for output to be processed

    window_id = Repla::Test::Helper.window_id
    window = Repla::Window.new(window_id)

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

    window.close
  end
end
