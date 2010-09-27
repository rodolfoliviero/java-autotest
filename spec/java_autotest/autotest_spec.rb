require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe AutoTest do

  before(:each) do
    test_runner = mock(TestRunner)
    TestRunner.stub!(:new).and_return(test_runner)
    test_runner.should_receive(:run_all_tests)
    @autotest = AutoTest.new
    @class = "src/main/java/app/model/Order.java"
  end

  context "run test" do

    before(:each) do
      @autotest.test_runner.stub!(:run_test).and_return false
    end  

    it "should reset run_at after run" do
      now = mock(Time)
      Time.stub!(:new).and_return(now)
      @autotest.run(@class)
      @autotest.run_at.should == now
    end

    it "cannot run all test if test fail" do
      @autotest.test_runner.should_not_receive(:run_all_tests)
      @autotest.run(@class)
    end

    it "should run all test if test pass" do
      @autotest.test_runner.stub!(:run_test).and_return true
      @autotest.test_runner.should_receive(:run_all_tests)
      @autotest.run(@class)
    end

    it "should notify user when test fail" do
      @autotest.should_receive(:notify)
      @autotest.run(@class)
    end
    
  end

  it "should find test class name when class is not a test class" do
    test_class = @autotest.find_test_class(@class)
    test_class.should == "OrderTest"
  end

  it "should find test class name when class is a test class" do
    test_class = @autotest.find_test_class("src/test/java/app/model/OrderTest.java")
    test_class.should == "OrderTest"
  end

end
