class Parser
	MATCH_PATTERN = /^\d+ \d+ (\d+\.\d+\.\d+\.\d+) (\d+\.\d+\.\d+\.\d+) \d+ \d+ (\d+) (\d+) (\d+) .*$/

	SKIP_PATTERNS = [
		/^File processing finished/, 
		/^Processing file/,
		/^timestamp account_id source/
	]

	attr_accessor :records

	def initialize
		self.records = []
	end

	def parse_file!(filename)
		file = File.new(filename, "r")

		while (line = file.gets)
			record = parse_line(line)
			self.records << record if record
		end

		file.close
	end

protected

	def parse_line(line)
		return nil if line_to_skip?(line)
	  match_data = line.match MATCH_PATTERN
		build_record match_data
	end

	def build_record(match_data)
		Record.new match_data[1], match_data[2], match_data[3].to_i, match_data[4].to_i, match_data[5].to_i
		# TODO do this in more readable way, say:   Record.new :source_address => match_data[1]....
	end

	def line_to_skip?(line)
		SKIP_PATTERNS.any? { |skip_pattern| line =~ skip_pattern }
	end
end
