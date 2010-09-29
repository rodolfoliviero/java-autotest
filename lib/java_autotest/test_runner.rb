class TestRunner
  attr_accessor :build_tool
  ICON = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'img', 'java_icon.png'))
  Title = 'Java AutoTest'  

  def self.valid_tools
    %w(mvn gradle)
  end

  def initialize
    @build_tool = discover_build_tool
  end

  def discover_build_tool
    "mvn"
    #"gradle" if File.exists?("build.gradle")
  end

  def run_test(test_class)
    green = system("#{@build_tool} -Dtest=#{test_class} test")
    notify "Test Failure: #{test_class}" unless green
    green
  end

  def run_all_tests
    green = system("#{@build_tool} test")
    notify "Build Passed" if green
    notify "Build Broken" unless green 
  end

  def notify(message)
    case RUBY_PLATFORM
    when /darwin/
      system "growlnotify -t '#{Title}' -m '#{message}' --image #{ICON}"
    when /linux/
      system "notify-send '#{Title}' '#{message}' --icon #{ICON}"
    end
  end

end
