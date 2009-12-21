#!/usr/bin/ruby

__DIR__ = File.dirname(__FILE__)
require File.join(__DIR__, 'init')

def print_results(split_traffic)
  
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
  
user_address = '77.235.9.36'
log_file_name = 'sample.log'

parser = Parser.new
parser.parse_file!(log_file_name)

traffic_calculator = TrafficCalculator.new local_address, records
split_traffic = traffic_calculator.split_traffic!

print_results(spit_traffic)