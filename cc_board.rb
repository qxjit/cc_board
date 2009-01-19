$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/rack-0.4.0/lib"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/sinatra-0.3.3/lib"

require 'rubygems'
require 'sinatra'
require 'lib/configuration'
require 'lib/build_list'

get "/" do
  @build_lists = Dir[Configuration.build_data_dir + "/*"].map do |filename|
    BuildList.new filename
  end

  erb :index
end

