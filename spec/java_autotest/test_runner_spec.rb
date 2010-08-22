require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe TestRunner do
  
  it "should run all tests" do
  	TestRunner.should_receive(:system).with("mvn test")
  	TestRunner.run_all_tests
  end
  
  it "should run single test" do
  	test_class = "ImplTest.java"
  	TestRunner.should_receive(:system).with("mvn -Dtest=#{test_class} test")
  	TestRunner.run_test(test_class)
  end
  
end
