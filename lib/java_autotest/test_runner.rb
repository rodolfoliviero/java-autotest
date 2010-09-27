class TestRunner
  attr_accessor :build_tool

  def self.valid_tools
    %w(mvn gradle)
  end

  def initialize
    @build_tool = discover_build_tool
    #@tool = "gradle" if File.exists?("build.gradle")
  end

  def discover_build_tool
    "mvn"
  end

  def run_test(test_class)
    system("#{@build_tool} -Dtest=#{test_class} test")
  end

  def run_all_tests
    system("#{@build_tool} test")
  end

end
