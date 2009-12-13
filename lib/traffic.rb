class Traffic
	attr_accessor :local_address
	attr_reader :records
	
	def initialize(records, local_address_found = false)
		@records = records
		@local_address = (local_address_found) ? local_address_found : local_address_find
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

    def local_address_find
        if (@records[0])
           ip1, ip2 = @records[0].map {|address| address}
        end
        @records.each do |record|
           ipn1, ipn2 = record.map {|address| address}
           if (ip1!=ipn1 && ip1!=ipn2) then
             return ip2
           else if (ip2!=ipn1 && ip2!=ipn2) then
                  return ip1
                end
           end
        end
        ip2
    end
end
