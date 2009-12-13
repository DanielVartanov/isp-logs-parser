#!/usr/bin/ruby

current_directory = File.dirname(__FILE__)
require File.join(current_directory, 'init')

require 'rubygems'
require 'sinatra'
require 'erb'
require 'resolv'

get '/' do
  erb :main
end

post '/' do
  tempfile = params[:logsfile][:tempfile]

  traffic_calculator = TrafficCalculator.new tempfile.path 
  traffic_calculator.calculate!
  @data = traffic_calculator.get_results    

  erb :results
end

get '/resolve/:ip' do
  resolver = Resolv::DNS.new
  begin
    resolver.getname(params[:ip]).to_s
  rescue Resolv::ResolvError
    params[:ip]
  end
end


