#
# to_python_type.rb
#

module Puppet::Parser::Functions
  newfunction(:to_python_type, :type => :rvalue, :doc => <<-EOS
Returns the python type value from a ruby type: for example true becomes
True. It takes a single value as an argument.
EOS
  ) do |arguments|

    raise(Puppet::ParseError, "to_python_type(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size != 1

    value = arguments[0]

    result = case value.class.name
    when /(True|False|Nil)Class/
      value.to_s.capitalize
    when "Hash"
      output = []
      value.map{|k,v| output<<"'#{k}':'#{v.to_s}'"}
      "{" << output.join(',') <<"}"
    else
      value
    end

    return result
  end
end

