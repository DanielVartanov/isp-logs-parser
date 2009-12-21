class Traffic < Scope
  attr_accessor :local_address
  
  define_scope :internal, proc { |record| record.internal? }
  define_scope :world, proc { |record| record.world? }
  define_scope :daily, proc { |record| record.daily? }
  define_scope :nightly, proc { |record| record.nightly? }
  define_scope :outcoming, proc { |record| record.source_address == local_address }
  define_scope :incoming, proc { |record| record.destination_address == local_address }

  def highest_ten_hosts
    highest_hosts(10)
  end

protected

  def hosts
    @hosts ||= grouped_by_host.map { |host_address, records| Host.new(host_address, records) }
  end

  def highest_hosts(limit=0)
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
