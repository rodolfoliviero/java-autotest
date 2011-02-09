class AutoTest
  attr_accessor :run_at, :files, :test_runner

  def initialize
    @files = File.find_java_files
    @test_runner = TestRunner.new
    @test_runner.run_all_tests
    @run_at = Time.new
  end	

  def listen
    @files = File.find_java_files
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
    @test_runner.run_all_tests if green
    reset 
  end

  def find_test_class(file)
    return file.split("/").last.split(".java").last.concat("Test") unless file.include? "Test.java"
    file.split("/").last.split(".").first
  end

  def reset
    @run_at = Time.new
  end
end
