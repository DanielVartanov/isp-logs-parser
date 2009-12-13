class TrafficCalculator < Struct.new(:log_file_name)
	def calculate!
		parser = Parser.new
		parser.parse_file!(self.log_file_name)

		@traffic = Traffic.new(parser.records)
	end

	def get_results
    res = Hash.new
    res[:intraffic] = Array.new()
    res[:outtraffic] = Array.new()

		@traffic.incoming.highest_hosts(10).each do |host|
      res[:intraffic].push(Hash["IP" => host.address , "size" => nice_bytes(host.amount_of_traffic)])
		end

		@traffic.outcoming.highest_hosts(10).each do |host|
      res[:outtraffic].push(Hash["IP" => host.address , "size" => nice_bytes(host.amount_of_traffic)])
		end

    res
	end

	def print_results
		puts results_string
    end

  def results_string
    result = ''

    result << "\n=== Incoming traffic ===\n"
		@traffic.incoming.highest_hosts(10).each do |host|
			result << "#{self.user_address} <- #{host.address} [#{nice_bytes(host.amount_of_traffic)}]\n"
		end

		result << "\n=== Outcoming traffic ===\n"
		@traffic.outcoming.highest_hosts(10).each do |host|
			result << "#{self.user_address} -> #{host.address} [#{nice_bytes(host.amount_of_traffic)}]\n"
		end

    result
  end

protected

	def print_first_ten_hosts(traffic)
		traffic.highest_hosts(10).each do |host|
			puts "#{self.user_address} <- #{host.address} [#{nice_bytes(host.amount_of_traffic)}]"
		end
	end
end
