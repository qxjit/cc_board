$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/rack-0.4.0/lib"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/sinatra-0.3.3/lib"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/vendor/thoughtbot-shoulda-2.0.6/lib"

require 'rubygems'
require 'sinatra'
require 'sinatra/test/unit'
require File.dirname(__FILE__) + "/../cc_board"

require 'shoulda'

class IndexTest < Test::Unit::TestCase
  should "say hello" do
    get_it "/"
    assert_equal "Hello Sinatra", @response.body
  end
end
