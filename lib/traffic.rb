class Traffic < Struct.new(:records, :local_address)
	def incoming
		self.records.select { |record| record.destination_address == self.local_address }
	end

	def outcoming
		self.records.select { |record| record.source_address == self.local_address }
	end
	
	def to_set
		self.records.to_set
	end
end
