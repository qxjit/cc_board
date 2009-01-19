this_dir = File.dirname(__FILE__)

$LOAD_PATH.unshift "#{this_dir}/../vendor/thoughtbot-shoulda-2.0.6/lib"
$LOAD_PATH.unshift "#{this_dir}/../vendor/rack-0.4.0/lib"
$LOAD_PATH.unshift "#{this_dir}/../vendor/sinatra-0.3.3/lib"

require 'test/unit'
require 'shoulda'
require 'rubygems'
require 'sinatra'
require 'sinatra/test/unit'
require "#{this_dir}/../cc_board"
require "#{this_dir}/../build_poller"

# Views is set relative to the test file rather than the app file
Sinatra.options.views = "#{this_dir}/../views"
Configuration.build_data_dir = "#{this_dir}/builds"
