$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/rack-0.4.0/lib"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/sinatra-0.3.3/lib"

require 'rubygems'
require 'sinatra'
require 'rexml/document'

configure :production, :development do
  BUILD_DATA_DIR = File.dirname(__FILE__) + "/builds"
end

configure :test do
  BUILD_DATA_DIR = File.dirname(__FILE__) + "/test/builds"
end

get "/" do
  @builds = []

  Dir[BUILD_DATA_DIR + "/*"].each do |filename|
    doc = REXML::Document.new(File.read(filename))
    doc.root.each_element("//Project") do |build_element|
      @builds << build_element.attributes["name"]
    end
  end

  erb :index
end

