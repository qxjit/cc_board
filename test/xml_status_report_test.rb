require File.dirname(__FILE__) + '/test_helper'

class IndexTest < Test::Unit::TestCase
  def self.should_contain_build(build_name)
    should "contain build: #{build_name}" do
      doc = REXML::Document.new @response.body
      assert_not_nil REXML::XPath.first(doc, "//Project[@name = '#{build_name}']")
    end
  end

  context "the XmlStatusReport.apsx page" do
    setup { get_it "/XmlStatusReport.aspx" }

    should_contain_build "server1 build1"
    should_contain_build "server1 build2"
    should_contain_build "server2 build1"
    should_contain_build "server2 build2"
  end
end
