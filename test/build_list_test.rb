require File.dirname(__FILE__) + '/test_helper'

class BuildListTest < Test::Unit::TestCase
  context "a list parsed from cc_tray output" do
    setup do
      @file = Tempfile.new("build_list_test")
      @file << <<-END_XML
<Projects>
  <Project name="passing build" webUrl="http://test/build1" lastBuildStatus="RandomNonFailureStatus"/>
  <Project name="failing build" webUrl="http://test/build2" lastBuildStatus="Failure"/>
</Projects>
      END_XML
      @file.flush
      @list = BuildList.new(@file.path)
    end

    teardown {@file.close}

    should "contain all builds"  do
      assert_contains @list.map {|b| b.name}, "passing build"
      assert_contains @list.map {|b| b.name}, "failing build"
    end

    should "indicate failure for builds with last status Failure" do
      assert_equal "failure", @list.find {|b| b.name == "failing build"}.status
    end

    should "indicate success for builds with any status other than failure" do
      assert_equal "success", @list.find {|b| b.name == "passing build"}.status
    end
  end
end
