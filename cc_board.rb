$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/rack-0.4.0/lib"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/sinatra-0.3.3/lib"

require 'rubygems'
require 'sinatra'
require 'rexml/document'
require 'lib/configuration'

get "/" do
  @builds = []

  Dir[Configuration.build_data_dir + "/*"].each do |filename|
    doc = REXML::Document.new(File.read(filename))
    doc.root.each_element("//Project") do |build_element|
      @builds << build_element.attributes["name"]
    end
  end

  erb :index
end

