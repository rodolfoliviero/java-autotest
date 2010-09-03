require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe BuildTool do
	
  context "valid build tools" do
    it "should support maven" do
    	BuildTool.valid_tools.include?("mvn").should be_true
    end
    
    it "should support gradle" do
		BuildTool.valid_tools.include?("gradle").should be_true
    end
  end
  
	it "should run all tests" do
	  	BuildTool.should_receive(:system).with("mvn test").and_return true
	  	BuildTool.run_all_tests.should be_true
	end
  
  context "run single test" do
  	
	before(:each) do
		@test_class = "ImplTest"
	end
  
    it "should run maven single test" do
    	command = "mvn -Dtest=#{@test_class} test"
    	BuildTool.should_receive(:system).with(command).and_return true
		BuildTool.run_test(@test_class).should be_true
    end
    
    xit "should run gradle single test" do
		BuildTool.new.single_test_command("").should == "gradle -Dtest.single=#{@test_class} test"
    end
  end
  
end
