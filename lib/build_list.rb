require 'rexml/document'

class BuildList
  include Enumerable

  def initialize(filename)
    @filename = filename
  end

  def each
    doc = REXML::Document.new(File.read(@filename))
    if doc && doc.root
      doc.root.each_element("//Project") do |build_element|
        yield Build.new(build_element.attributes["name"], 
                        build_element.attributes["lastBuildStatus"].downcase,
                        build_element.attributes["activity"].downcase,
                        build_element.attributes["webUrl"])
      end
    end
  end

  class Build
    attr_reader :name, :status, :activity, :url

    def initialize(name, status, activity, url)
      @name, @status, @activity, @url = name, status, activity, url
    end
  end
end
