require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Traffic do
	describe "given a bunch of records" do
		before :each do
			@local_address = '192.168.0.1'
			@facebook = '77.235.14.9'
			@gmail = '77.235.14.10'

			@records = [
				Record.new(@local_address, @facebook, 1),			
				Record.new(@facebook, @local_address, 1),
				Record.new(@local_address, @gmail,2),
				Record.new(@gmail, @local_address, 2)
			]
		end

		describe "given a Traffic instance loaded with records" do
			before :each do
				@traffic = Traffic.new @records        
			end			

			describe "when #hightest_hosts is called without argumt" do
				before :each do
					@return_value = @traffic.highest_hosts
				end

				it "should return hosts in descending order of amount of traffic" do
					@return_value.length.should == 2

					@return_value[0].address.should == @gmail
					@return_value[0].amount_of_traffic.should == 4
					
					@return_value[1].address.should == @facebook
					@return_value[1].amount_of_traffic.should == 2
				end
			end

			describe "when #highest_hosts is called with an argument" do
				before :each do
					@return_value = @traffic.highest_hosts(1)
				end

				it "should return only given amount of highest hosts" do
					@return_value.length.should == 1
					@return_value.first.address.should == @gmail					
					@return_value.first.amount_of_traffic == 4
				end
			end
		end
	end
end