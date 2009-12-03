#!/usr/bin/ruby

def get_results (file_name)
  __DIR__ = File.dirname(__FILE__)
  require File.join(__DIR__, 'init')

  user_address = '77.235.9.36'

  traffic_calculator = TrafficCalculator.new file_name, user_address
  traffic_calculator.calculate!
  #traffic_calculator.print_results
  traffic_calculator.get_results
end
