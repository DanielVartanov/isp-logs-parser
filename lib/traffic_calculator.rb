class TrafficCalculator < Struct.new(:log_file_name, :user_address)
	def calculate!
		parser = Parser.new
		parser.parse_file!(self.log_file_name)

		@traffic = Traffic.new(parser.records, self.user_address)
	end

	def print_results
		puts "\n=== Incoming traffic ==="
		@traffic.incoming.highest_hosts(10).each do |host|
			puts "#{self.user_address} <- #{host.address} [#{nice_bytes(host.amount_of_traffic)}]"
		end

		puts "\n=== Outcoming traffic ==="
		@traffic.outcoming.highest_hosts(10).each do |host|
			puts "#{self.user_address} -> #{host.address} [#{nice_bytes(host.amount_of_traffic)}]"
		end
	end

protected

	def print_first_ten_hosts(traffic)
		traffic.highest_hosts(10).each do |host|
			puts "#{self.user_address} <- #{host.address} [#{nice_bytes(host.amount_of_traffic)}]"
		end
	end
end
