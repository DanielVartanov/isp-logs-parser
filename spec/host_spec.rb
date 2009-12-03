require File.join(File.dirname(__FILE__), 'spec_helper')

describe Host do
	describe "given a host loaded with a bunch of records" do
		before :each do
			@local_address = '77.234.14.2'
			@remote_address = '213.145.129.19'
			@host = Host.new(@remote_address)
			@host.records = [
				Record.new(@local_address, @remote_address, 1),			
				Record.new(@remote_address, @local_address, 2),
				Record.new(@local_address, @remote_address,4),
			]
		end
		
		describe "when #amount_of_trafic is called" do
			before :each do
				@return_value = @host.amount_of_traffic
			end
			
			it "should return summ of records bytes count" do
				@return_value.should == 7
			end
		end
	end
end
