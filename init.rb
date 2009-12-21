require 'rubygems'
require 'active_support'

__DIR__ = File.dirname(__FILE__)

require File.join(__DIR__, 'vendor', 'scopes-n-groups', 'lib', 'scope')

Dir.glob(File.join(__DIR__, 'lib', '**', '*.rb')).each { |file| require file }