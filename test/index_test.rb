$LOAD_PATH.unshift File.dirname(__FILE__) + "/../vendor/rack-0.4.0/lib"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/../vendor/sinatra-0.3.3/lib"

require 'rubygems'
require 'sinatra'
require 'sinatra/test/unit'
require File.dirname(__FILE__) + "/../cc_board"

# Views is set relative to the test file rather than the app file
Sinatra.options.views = File.dirname(__FILE__) + "/../views"

$LOAD_PATH.unshift File.dirname(__FILE__) + "/../vendor/thoughtbot-shoulda-2.0.6/lib"
require 'shoulda'

class IndexTest < Test::Unit::TestCase
  def self.should_show_build(build_name)
    should "show show build: #{build_name}" do
      assert_match build_name, @response.body
    end
  end

  context "the index page" do
    setup { get_it "/" }

    should_show_build "server1 build1"
    should_show_build "server1 build2"
    should_show_build "server2 build1"
    should_show_build "server2 build2"
  end
end
