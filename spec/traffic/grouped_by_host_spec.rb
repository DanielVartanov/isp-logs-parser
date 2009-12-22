require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Traffic do
	describe "given a bunch of records" do
		before :each do
			@local_address = '192.168.0.1'
			@facebook = '77.235.14.9'
			@gmail = '77.235.14.10'

			@records = [
				Record.new(@local_address, @facebook),
				Record.new(@local_address, @gmail),
				Record.new(@facebook, @local_address),
				Record.new(@gmail, @local_address)
			]
		end

		describe "given a Traffic instance loaded with records" do
			before :each do
				@traffic = Traffic.new(@records)        
			end			

			describe "when after that #group_by_host is called" do
				before :each do
					@return_value = @traffic.grouped_by_host
				end

				it "should return records grouped by *remote* host" do
					@return_value.to_hash.should == {
						@facebook => [Record.new(@facebook, @local_address), Record.new(@local_address, @facebook)],
						@gmail => [Record.new(@gmail, @local_address), Record.new(@local_address, @gmail)]
					}
				end					
			end	
		end
	end
end
