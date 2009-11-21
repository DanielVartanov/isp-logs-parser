__DIR__ = File.dirname(__FILE__)
require File.join(__DIR__, 'spec_helper')

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
				
				it "should return incoming records only" do
					@return_value.to_set == [Record.new(@facebook, @local_address), Record.new(@gmail, @local_address)]
				end
			end
			
			describe "when #outcoming is called" do
				before :each do
					@return_value = @traffic.outcoming
				end

				it "should return outcoming records only" do
					@return_value.to_set == [Record.new(@local_address, @facebook), Record.new(@local_address, @gmail)]
				end
			end
		end
	end
end
