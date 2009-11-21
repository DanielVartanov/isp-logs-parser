class Traffic
	attr_accessor :local_address
	attr_reader :records
	
	def initialize(records, local_address)
		@records = records
		@local_address = local_address
	end

	def incoming
		@incoming ||= self.records.select { |record| record.destination_address == self.local_address }
	end

	def outcoming
		@outcoming ||= self.records.select { |record| record.source_address == self.local_address }
	end
	
	def to_set
		self.records.to_set
	end
end
