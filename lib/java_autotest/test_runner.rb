class TestRunner
  def self.run_test(test_class)
		system("mvn -Dtest=#{test_class} test")
	end
	
	def self.run_all_tests
		system("mvn test")
	end
end

#gradle goals
#single test => "gradle -Dtest.single=#{test_class} test"
#all tests => "gradle test"
