require 'rubygems'
require 'bundler/setup'
require File.expand_path(File.join(File.dirname(__FILE__), 'lib/geoip_server'))

## There is no need to set directories here anymore;
## Just run the application

run Sinatra::Application
