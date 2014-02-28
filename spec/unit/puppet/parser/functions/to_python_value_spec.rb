#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe "the to_python_type function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    Puppet::Parser::Functions.function("to_python_type").should == "function_to_python_type"
  end

  it "should raise a ParseError if there is less than 1 arguments" do
    lambda { scope.function_to_python_type([]) }.should( raise_error(Puppet::ParseError))
  end

  it "should convert a ruby bool into a string to a python bool" do
    result = scope.function_to_python_type([true])
    result.should(eq("True"))
  end

  it "should do nothing with a normal string" do
    result = scope.function_to_python_type(["howdy"])
    result.should(eq("howdy"))
  end

  it "should do nothing with a number" do
    result = scope.function_to_python_type(["1238"])
    result.should(eq("1238"))
  end

  it "should convert a ruby hash to a python hash" do
    result = scope.function_to_python_type([{"key"=>"value"}])
    result.should(eq("{'key':'value'}"))
  end
end
