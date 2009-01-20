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
    Net::HTTP.get_response(uri) do |response|
      File.open(@build_directory + "/#{uri.host}.#{uri.port}", "w") do |f|
        f << response.body
      end
    end
  end
end

if __FILE__ == $0
  require 'lib/configuration'
  servers = File.readlines(Configuration.servers_file).map {|l| l.strip}.reject {|l| l.empty?}
  poller = BuildPoller.new(servers, Configuration.build_data_dir)
  loop do
    poller.poll_once
    sleep 20
  end
end
