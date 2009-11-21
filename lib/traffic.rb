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
