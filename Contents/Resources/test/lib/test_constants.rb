TEST_PLUGIN_PATH = File.expand_path(File.join(__dir__,
                                              '../../../..'))
TEST_PLUGIN_NAME = 'IRB'.freeze

TEST_CODE = %[def add_numbers(num1, num2)
  return num1 + num2
end
add_numbers(1, 2)].freeze
TEST_CODE_RESULT = 3
