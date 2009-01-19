require 'rexml/document'

class BuildList
  include Enumerable

  def initialize(filename)
    @filename = filename
  end

  def each
    doc = REXML::Document.new(File.read(@filename))
    doc.root.each_element("//Project") do |build_element|
      yield Build.new(build_element.attributes["name"], 
                      map_cc_tray_status(build_element.attributes["lastBuildStatus"]))
    end
  end

  def map_cc_tray_status(status)
    {
      "Failure" => "failure",
    }[status] || "success"
  end

  class Build
    attr_reader :name, :status

    def initialize(name, status)
      @name, @status = name, status
    end
  end
end
