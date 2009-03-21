require 'rexml/document'

class BuildList
  include Enumerable

  def initialize(filename)
    @filename = filename
  end

  def each
    each_xml_element do |build_element|
      yield Build.new(build_element.attributes["name"], 
                      build_element.attributes["lastBuildStatus"].downcase,
                      build_element.attributes["activity"].downcase,
                      build_element.attributes["webUrl"])
    end
  end

  def insert_into(document)
    each_xml_element do |build_element|
      document.root.add_element build_element.clone
    end
  end

  def each_xml_element
    doc = REXML::Document.new(File.read(@filename))
    if doc && doc.root
      doc.root.each_element("//Project") do |build_element|
        yield build_element
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
