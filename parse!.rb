#!/usr/bin/ruby

require File.join(File.dirname(__FILE__), 'init')

def result_string(hosts)
  require File.join(File.dirname(__FILE__), 'vendor', 'terminal-table', 'lib', 'terminal-table')
  require 'terminal-table/import'

  results_table = table ['host', 'traffic', 'day/night', 'location']

  hosts.each do |host|
    results_table << [host.address,
      nice_bytes(host.amount_of_traffic),
      host.daily? ? 'daily' : 'nightly',
      host.internal? ? 'internal' : 'world'
    ]
  end

  results_table
end

if ARGV.size < 1
  puts "usage: parse\\!.rb log-file"
  exit 1
end

log_file_name = ARGV[0]
puts "Parsing #{log_file_name}..."

parser = Parser.new
records = parser.parse_file!(log_file_name)
puts "#{records.size} records read"

puts "Calculating...\n\n"
traffic = Traffic.new records
split_traffic = TrafficSplitter.split_traffic!(traffic)

puts result_string(split_traffic)