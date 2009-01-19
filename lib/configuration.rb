module Configuration
  class <<self
    attr_accessor :build_data_dir
    attr_accessor :servers_file
  end
  self.build_data_dir = File.expand_path(File.dirname(__FILE__) + "/../builds")
end
