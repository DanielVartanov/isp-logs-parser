#!/usr/bin/ruby

require File.join(File.dirname(__FILE__), 'init')

def pretty_host(host)
  "#{host.address} [#{nice_bytes(host.amount_of_traffic)}]"
end

def result_string(split_traffic)
  require File.join(File.dirname(__FILE__), 'vendor', 'terminal-table', 'lib', 'terminal-table')
  require 'terminal-table/import'
  t = table ['', 'internal', 'world']

  t << ['daily', pretty_host(split_traffic[:internal][:daily].first), pretty_host(split_traffic[:world][:daily].first)]

  1.upto(9).each do |index|
    t << ['', pretty_host(split_traffic[:internal][:daily][index]), pretty_host(split_traffic[:world][:daily][index])]
  end
  
  t.add_separator

  t << ['nightly', pretty_host(split_traffic[:internal][:nightly].first), pretty_host(split_traffic[:world][:nightly].first)]
  
  1.upto(9).each do |index|
    t << ['', pretty_host(split_traffic[:internal][:nightly][index]), pretty_host(split_traffic[:world][:nightly][index])]
  end

  t
end

puts ARGV.inspect

if ARGV.size < 1
  puts "usage: parse\\!.rb log-file"
  exit 1
end

log_file_name = ARGV[0]

parser = Parser.new
records = parser.parse_file!(log_file_name)
puts "#{records.size} records read from #{log_file_name}\n\n"
traffic = Traffic.new records
split_traffic = TrafficSplitter.split_traffic!(traffic)

puts result_string(split_traffic)