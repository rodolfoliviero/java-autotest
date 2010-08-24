require File.dirname(__FILE__) + '/../lib/java_autotest/autotest'
require File.dirname(__FILE__) + '/../lib/java_autotest/file'
require File.dirname(__FILE__) + '/../lib/java_autotest/test_runner'
require File.dirname(__FILE__) + '/../lib/java_autotest/build_tool'

module JavaAutoTest
	class Main
		def self.execute
			TestRunner.run_all_tests
			autotest = AutoTest.new
			loop do
	      		begin
	        		sleep until autotest.listen
	      		rescue Interrupt
	        		break
	      		end
	      	end
	    end
  	end
end





