#!/usr/bin/ruby

# TODO
# Указание провайдера хоста, если KG и "мир" если мир.
# {
#   'KT' => [start_ip, end_ip],
#   ...
# }
#
# Деление на день и ночь.
# {
#   'day' => [start_time, end_time]
# }
# 
# Push to GitHub (yeah! isp-logs-parser)
#
# DNS резолвинг
#
# Сервер на Синатре, куда аплоадить файл и смотреть
#
# Суси -> оформить

require 'parser'
require 'benchmark'
require 'nice_bytes'

@user_address = '77.235.9.36'

filename = 'log.txt'
puts "Parsing file #{filename}..."
file = File.new(filename, "r")

# skip first line
file.gets

@records = []
benchmark = Benchmark.measure do
  while (line = file.gets)
    @records << LogRecord.parse(line) unless line =~ /^File processing finished/ || line =~ /^Processing file/
  end

  puts "#{@records.size} lines parsed"
end
puts benchmark

puts "Grouping by host..."

@incoming_traffic = {}
@outcoming_traffic = {}
benchmark = Benchmark.measure do
  @records.each do |record|
     if record.source_address == @user_address
       (@outcoming_traffic[record.destination_address] ||= []) << record
     else
       (@incoming_traffic[record.source_address] ||= []) << record
     end
  end

  puts "@incoming_traffic.size = #{@incoming_traffic.size} @outcoming_traffic.size = #{@outcoming_traffic.size}"
end
puts benchmark

puts "Calculating count of bytes..."

def calculate_bytes_count(traffic, target_hash)
  traffic.each_pair do |address, records|
    bytes_count = 0
    records.each { |record| bytes_count += record.bytes }
    target_hash[address] = bytes_count
  end
end

@incoming_bytes = {}
@outcoming_bytes = {}
benchmark = Benchmark.measure do
  calculate_bytes_count @incoming_traffic, @incoming_bytes
  calculate_bytes_count @outcoming_traffic, @outcoming_bytes
end
puts benchmark

puts "Sorting..."

benchmark = Benchmark.measure do
  @incoming_bytes = @incoming_bytes.sort { |left, right| right[1] <=> left[1] }
  @outcoming_bytes = @outcoming_bytes.sort { |left, right| right[1] <=> left[1] }
end
puts benchmark

puts "=== Incoming traffic ==="
@incoming_bytes.first(10).each do |pair|
  puts "#{@user_address} <- #{pair[0]} [#{nice_bytes(pair[1])}]"
end

puts "\n=== Outcoming traffic ==="
@outcoming_bytes.first(10).each do |pair|
  puts "#{@user_address} -> #{pair[0]} [#{nice_bytes(pair[1])}]"
end