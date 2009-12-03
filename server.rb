current_directory = File.dirname(__FILE__)
require File.join(current_directory, 'init')

require 'rubygems'
require 'sinatra'

post '/' do
  tempfile = params[:file][:tempfile]
  
  traffic_calculator = TrafficCalculator.new tempfile.path, '77.235.9.36'
  traffic_calculator.calculate!
  @result_string = traffic_calculator.results_string

  erb :results
end