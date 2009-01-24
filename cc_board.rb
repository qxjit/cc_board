$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/rack-0.4.0/lib"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/sinatra-0.3.3/lib"

require 'rubygems'
require 'sinatra'
require 'lib/configuration'
require 'lib/build_list'

ASSET_DIR = File.dirname(__FILE__) + "/public/"

helpers do
  def stylesheet(name)
    "<link href='#{versioned_asset(name + ".css")}' rel='stylesheet'/>"
  end

  def javascript(name)
    "<script type='text/javascript' src='#{versioned_asset(name + ".js")}'></script>"
  end

  def versioned_asset(filename)
    "#{filename}?#{File.mtime(ASSET_DIR + filename).to_i}"
  end
end

get "/" do
  @build_lists = Dir[Configuration.build_data_dir + "/*"].map do |filename|
    BuildList.new filename
  end

  erb :index
end

