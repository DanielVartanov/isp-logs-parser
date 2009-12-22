require File.join(File.dirname(__FILE__), 'spec_helper')

describe Parser do
	before :each do
		@parser = Parser.new
	end

	describe "given a log file" do
		before :all do
			file_content = <<LOG
timestamp account_id source destination t_class packets bytes sport dport date
Processing file: /netup/utm5/db/iptraffic_raw_1250876910.utm
1250878466 144 77.235.9.36 217.29.21.21 260 5 552 51003 80 Sat Aug 22 00:14:26 2009
File processing finished
Processing file: /netup/utm5/db/iptraffic_raw_1250876910.utm
1250878469 144 217.29.21.21 77.235.9.36 270 4 539 80 51005 Sat Aug 22 00:14:29 2009
File processing finished			
LOG
			@file_name = "test-#{rand(999999)}.log"
			file = File.open(@file_name, 'w')
			file.write file_content
			file.close
		end

		after :all do
			File.delete(@file_name)
		end

		describe "when parse_file! is called" do
			before :each do
				@parser.parse_file!(@file_name)
			end
			
			it "should correctly fill #records array" do
				@parser.records.to_set.should == [
					Record.new('77.235.9.36', '217.29.21.21', 552, 51003, 80, Time.at(1250878466)),
					Record.new('217.29.21.21', '77.235.9.36', 539, 80, 51005, Time.at(1250878469))
				].to_set
			end	
		end
	end
end
