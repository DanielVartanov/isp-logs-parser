# server.rb
require 'rubygems'
require 'sinatra'
require 'erb'

get '/' do
  erb :main
end

post '/eval' do  
  require 'parse!.rb'
  @data = get_results params[:logsfile][:tempfile].path
  erb :table
end

get '/resolve/:IP' do
  'www.resolvedname.kg'  
end

