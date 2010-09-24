class BuildTool
  Tool
  
  def self.valid_tools
    %w(mvn gradle)
  end

  def self.run_test(test_class)
    system("#{Tool} -Dtest=#{test_class} test")
  end

  def self.run_all_tests
    system("#{Tool} test")
  end
  
  def self.configure_and_run
    Tool = "mvn" if File.exists("pom.xml")
    Tool = "gradle" if File.exists("build.gradle")
    run_all_tests
  end
end
