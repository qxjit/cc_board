require File.dirname(__FILE__) + '/test_helper'
require 'hpricot'

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

    should "have all stylesheet and javascript assets versioned with timestamps" do
      doc = Hpricot.parse(@response.body)
      doc.get_elements_by_tag_name("link").each do |link|
        assert_asset_versioned(link["href"]) if link["rel"] =~ /stylesheet/i
      end

      doc.get_elements_by_tag_name("script").each do |script|
        assert_asset_versioned(script["src"]) if script["src"]
      end
    end
  end
  
  def assert_asset_versioned(asset)
    filename, version = asset.split('?')
    flunk "#{filename} was not versioned" unless version
    assert_equal version.to_i, File.mtime(File.dirname(__FILE__) + "/../public/#{filename}").to_i,
                 "#{filename} was not given correct version"
  end
end
