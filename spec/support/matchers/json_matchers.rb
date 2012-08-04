require 'active_support/json'

# Adapted from http://www.ruby-forum.com/topic/183584#999733
RSpec::Matchers.define :be_json_eql do |expected_json_string|
  match do |actual_json_string|
    @expected = decode(expected_json_string, 'expected')
    @actual = decode(actual_json_string, 'actual')
    @actual == @expected
  end

  failure_message_for_should do |actual_json_string|
    message = "expected\n  #{actual_json_string}\nto be JSON equivalent to\n  #{expected_json_string}\n" 
    if @expected.respond_to?(:diff) && @actual.respond_to?(:diff)
      message << "Difference:\n#{@expected.diff(@actual).inspect}"
    end
    message
  end

  failure_message_for_should_not do |actual_json_string|
    "expected\n  #{actual_json_string}\nto be JSON different from\n  #{expected_json_string}"
  end

  def decode(json_string, which)
    ActiveSupport::JSON.decode(json_string)
  rescue
    raise ArgumentError, "Invalid #{which} JSON string (must be a String):\n\n  #{json_string.inspect}\n"
  end
end

