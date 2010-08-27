require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe BuildTool do

  context "valid build tools" do
    xit "should support maven" do
      BuildTool.valid_tools.include?("mvn").should be_true
    end
    
    it "should support gradle" do
      BuildTool.valid_tools.include?("gradle").should be_true
    end
  end
  
end
