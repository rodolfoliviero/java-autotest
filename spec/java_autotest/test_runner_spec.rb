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
    before(:all) do
      @test_runner = TestRunner.new
      @message = "java autotest is awesome!"
    end

    it "should notify user when build fail" do
      @test_runner.should_receive(:system).and_return false
      @test_runner.should_receive(:notify).with("Build Broken")
      @test_runner.run_all_tests
    end

    it "should notify user when all build pass" do
      @test_runner.stub!(:system).and_return true
      @test_runner.should_receive(:notify).with("Build Success")
      @test_runner.run_all_tests
    end

    it "should run all tests to maven" do
      @test_runner.should_receive(:system).with("mvn test").and_return true
      @test_runner.stub!(:notify)
      @test_runner.run_all_tests
    end

    it "should run all tests to gradle" do
      File.stub(:exists?).with("build.gradle").and_return true
      test_runner = TestRunner.new
      test_runner.stub!(:notify)
      test_runner.should_receive(:system).with("gradle test").and_return true
      test_runner.run_all_tests
    end
  end 

  context "single test" do
    before(:each) do
      @test_class = "ImplTest"
      @test_runner = TestRunner.new
    end

    it "should notify user when test fail" do
      @test_runner.should_receive(:system).and_return false
      @test_runner.should_receive(:notify).with("Test Failure: #{@test_class}")
      @test_runner.run_test(@test_class).should be_false
    end

    it "cannot notify user when test pass" do
      @test_runner.should_receive(:system).and_return true
      @test_runner.should_not_receive(:notify)
      @test_runner.run_test(@test_class).should be_true
    end

    it "should run single test to maven" do
      command = "mvn -Dtest=#{@test_class} test"
      @test_runner.should_receive(:system).with(command).and_return true
      @test_runner.run_test(@test_class).should be_true
    end

    it "should run gradle single test" do
      File.stub(:exists?).with("build.gradle").and_return true
      test_runner = TestRunner.new
      command = "gradle -Dtest.single=#{@test_class} test"
      test_runner.should_receive(:system).with(command).and_return true
      test_runner.run_test(@test_class).should be_true
    end
  end

  context "notify user" do
    before(:all) do
      @test_runner = TestRunner.new
      @current_platform = RUBY_PLATFORM 
      @message = "java autotest is awesome!"
    end

    after(:all) do
      RUBY_PLATFORM = @current_platform
    end

    it "should be able to notify on linux OS" do
      RUBY_PLATFORM = "linux"
      command = "notify-send '#{TestRunner::Title}' '#{@message}' --icon #{TestRunner::ICON}"
      @test_runner.should_receive(:system).with(command)
      @test_runner.notify(@message)
    end

    it "should be able to notify on Mac OS X" do
      RUBY_PLATFORM = "darwin"
      command = "growlnotify -t '#{TestRunner::Title}' -m '#{@message}' --image #{TestRunner::ICON}"
      @test_runner.should_receive(:system).with(command)
      @test_runner.notify(@message)
    end
  end

end
