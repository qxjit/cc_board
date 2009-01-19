require File.dirname(__FILE__) + '/test_helper'

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
