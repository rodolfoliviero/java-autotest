require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe TestRunner do

  context "valid build tools" do
    it "should support maven" do
      TestRunner.valid_tools.include?("mvn").should be_true
    end

    it "should support gradle" do
      TestRunner.valid_tools.include?("gradle").should be_true
    end
  end
 
 context "all tests" do
   it "should run all tests to maven" do
    test_runner = TestRunner.new
    test_runner.should_receive(:system).with("mvn test").and_return true
    test_runner.run_all_tests.should be_true
  end
  
  xit "should run all tests to gradle" do
    test_runner = TestRunner.new
    test_runner.should_receive(:system).with("gradle test").and_return true
    test_runner.run_all_tests.should be_true
  end
 end 
  
  context "single test" do
    before(:each) do
      @test_class = "ImplTest"
    end

    it "should run single test to maven" do
      command = "mvn -Dtest=#{@test_class} test"
      build_tool = TestRunner.new
      build_tool.should_receive(:system).with(command).and_return true
      build_tool.run_test(@test_class).should be_true
    end

    xit "should run gradle single test" do
      TestRunner.new.single_test_command("").should == "gradle -Dtest.single=#{@test_class} test"
    end
  end
  
end
