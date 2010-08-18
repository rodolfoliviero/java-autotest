require File.dirname(__FILE__) + '/../lib/java_autotest/autotest'
require File.dirname(__FILE__) + '/../lib/file'

module JavaAutoTest
	class Main
		def self.execute
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





