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
				@traffic = Traffic.new(@records, @local_address)
			end			
			
			describe "when #incoming is called" do
				before :each do
					@return_value = @traffic.incoming
				end
				
				it "should return a Traffic instance" do
					@return_value.should be_kind_of(Traffic)
				end

				it "should narrow records to incoming traffic only" do
					@return_value.records.to_set.should == [Record.new(@facebook, @local_address), Record.new(@gmail, @local_address)].to_set
				end
			end
			
			describe "when #outcoming is called" do
				before :each do
					@return_value = @traffic.outcoming
				end
				
				it "should return a Traffic instance" do
					@return_value.should be_kind_of(Traffic)
				end

				it "should narrow records to outcoming traffic only" do
					@return_value.records.to_set.should == [Record.new(@local_address, @facebook), Record.new(@local_address, @gmail)].to_set
				end
			end
		end
	end
end

