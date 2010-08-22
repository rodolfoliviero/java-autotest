require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe File do
	
	context "find java files in source folder" do
		before(:each) do
      @files = File.find_java_files("spec/src")
		end
	
		it "should find impl file" do
  		@files[0].should == "spec/src/main/java/Impl.java"
    end
  		
  	it "should find test file" do
  	  @files[1].should == "spec/src/test/java/ImplTest.java"
  	end
	end
	
end
