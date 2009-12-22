class Parser
  class ::MatchData
    def transferred_at; Time.at(self[1].to_i) end
    def source_address; self[2] end
    def destination_address; self[3] end
    def bytes; self[4].to_i end
    def source_port; self[5].to_i end
    def destination_port; self[6].to_i end
  end

	MATCH_PATTERN = /^(\d+) \d+ (\d+\.\d+\.\d+\.\d+) (\d+\.\d+\.\d+\.\d+) \d+ \d+ (\d+) (\d+) (\d+) .*$/

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

    self.records
	end

protected

	def parse_line(line)
		return nil if line_to_skip?(line)
	  match_data = line.match MATCH_PATTERN
		build_record match_data
	end

	def build_record(match_data)
		Record.new match_data.source_address,
      match_data.destination_address,
      match_data.bytes,
      match_data.source_port,
      match_data.destination_port,
      match_data.transferred_at
	end

	def line_to_skip?(line)
		SKIP_PATTERNS.any? { |skip_pattern| line =~ skip_pattern }
	end
end