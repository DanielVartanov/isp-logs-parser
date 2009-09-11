class LogRecord
  attr_accessor :source_address,
    :destination_address,
    :bytes,
    :source_port,
    :destination_port    

  def initialize(source_address, destination_address, bytes, source_port,
                 destination_port)
    self.source_address = source_address
    self.destination_address = destination_address
    self.bytes = bytes.to_i
    self.source_port = source_port
    self.destination_port = destination_port
  end

  def self.parse(line)
    line.match /^\d+ \d+ (\d+\.\d+\.\d+\.\d+) (\d+\.\d+\.\d+\.\d+) \d+ \d+ (\d+) (\d+) (\d+) .*$/
    self.new $1, $2, $3, $4, $5    
  end
end