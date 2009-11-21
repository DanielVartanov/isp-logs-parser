class Traffic
	attr_accessor :local_address
	attr_reader :records
	
	def initialize(records, local_address)
		@records = records
		@local_address = local_address
	end

	def incoming
		@incoming ||= self.records.select { |record| record.destination_address == self.local_address }
		self.class.new(@incoming, self.local_address)
	end

	def outcoming
		@outcoming ||= self.records.select { |record| record.source_address == self.local_address }
		self.class.new(@outcoming, self.local_address)
	end
	
	def hosts
		@hosts ||= grouped_by_host.map { |host_address, records| Host.new(host_address, records) }
	end
	
	def highest_hosts(limit=nil)
		sorted_hosts = hosts.sort { |left, right| right.amount_of_traffic <=> left.amount_of_traffic }
		limit.nil? ? sorted_hosts : sorted_hosts[0..limit-1]
	end
	
	def grouped_by_host
		return @grouped_by_host if @grouped_by_host
		
		@grouped_by_host = {}
		
		incoming.records.each do |record|
			(@grouped_by_host[record.source_address] ||= []) << record
		end

		outcoming.records.each do |record|
			(@grouped_by_host[record.destination_address] ||= []) << record
		end
		
		@grouped_by_host
	end
end
