class AutoTest
  attr_accessor :run_at, :files, :test_runner
  ICON = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'img', 'java_icon.png'))
  Title = 'Java AutoTest'

  def initialize
    @run_at = Time.new
    @files = File.find_java_files
    @test_runner = TestRunner.new
    @test_runner.run_all_tests
  end	

  def listen
    @files.each do |file|
      if (File.atime(file).to_i > @run_at.to_i)
        run(file) 
        break
      end
    end
    true
  end

  def run(file)
    test_class = find_test_class file
    puts "Running test to #{test_class}."
    green = @test_runner.run_test(test_class)
    if green
      all_test_green = @test_runner.run_all_tests
      notify "Build Passed" if all_test_green
      notify "Build Broken" unless all_test_green 
    else
      notify "Test Failure: #{test_class}"
    end
    reset 
  end

  def find_test_class(file)
    return file.split("/").last.split(".java").last.concat("Test") unless file.include? "Test.java"
    file.split("/").last.split(".").first
  end

  def reset
    @run_at = Time.new
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