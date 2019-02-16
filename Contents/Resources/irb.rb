#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require_relative 'bundle/bundler/setup'
require 'repla'

require_relative 'lib/wrapper'

wrapper = Repla::REPL::IRB::Wrapper.new

ARGF.each do |line|
  wrapper.parse_input(line)
end
