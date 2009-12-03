current_directory = File.dirname(__FILE__)
require File.join(current_directory, 'init')

require 'rubygems'
require 'sinatra'
require 'erb'

get '/' do
  erb :main
end

post '/' do
  tempfile = params[:file][:tempfile]
  
  traffic_calculator = TrafficCalculator.new tempfile.path, '77.235.9.36'
  traffic_calculator.calculate!
  @result_string = traffic_calculator.results_string

  @data = get_results params[:logsfile][:tempfile].path

  erb :results
end

get '/resolve/:IP' do
  'www.resolvedname.kg'
end