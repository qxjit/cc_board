require 'uri'
require 'net/http'

class BuildPoller
  def initialize(urls, build_directory)
    @urls = urls
    @build_directory = build_directory
  end

  def poll_once
    @urls.each do |url|
      poll_uri(URI.parse(url))
    end
  end

  def poll_uri(uri)
    File.open(@build_directory + "/#{uri.host}.#{uri.port}", "w") do |f|
      Net::HTTP.get_response(uri) do |response|
        f << response.body
      end
    end
  end
end
