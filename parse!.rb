#!/usr/bin/ruby

__DIR__ = File.dirname(__FILE__)
require File.join(__DIR__, 'init')

user_address = '77.235.9.36'
file_name = 'sample.log'

traffic_calculator = TrafficCalculator.new file_name, user_address
traffic_calculator.calculate!
traffic_calculator.print_results