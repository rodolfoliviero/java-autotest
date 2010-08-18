class AutoTest
	attr_accessor :data, :files

	def initialize
		@data = Time.new
		@files =  File.find_java_files
		#run_all_tests
	end	
	
	def listen
		@files.each do |file|
			if (File.atime(file).to_i > @data.to_i)
				run(file) 
				break
			end
		end
		true
	end
	
	def run(file)
		test_class = find_test_class file
		puts "Running test to #{test_class}."
		green = run_test(test_class)
		run_all_tests if green
		reset 
	end
	
	def find_test_class(file)
		return file.split("/").last.split(".java").last.concat("Test.java") unless file.include? "Test.java"
		return file.split("/").last if file.include? "Test.java"
	end
	
	def run_test(test_class)
		system("mvn -Dtest=#{test_class} test")
	end
	
	def run_all_tests
		system("mvn test")
	end
	
	def reset
		@data = Time.new
	end
end
