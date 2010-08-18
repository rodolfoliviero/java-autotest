require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe AutoTest do

  before(:each) do
  	@autotest = AutoTest.new
  end
   
  it "should run all tests" do
  	@autotest.should_receive(:system).with("mvn test")
  	@autotest.run_all_tests
  end
  
  it "should run single test" do
  	test_class = "ImplTest.java"
  	@autotest.should_receive(:system).with("mvn -Dtest=#{test_class} test")
  	@autotest.run_test(test_class)
  end
  
end
