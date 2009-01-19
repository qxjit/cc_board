require File.dirname(__FILE__) + "/../build_poller"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/../vendor/thoughtbot-shoulda-2.0.6/lib"
require 'test/unit'
require 'shoulda'
require 'socket'
require 'tmpdir'

class BuildPollerTest < Test::Unit::TestCase
  context "polling multiple servers" do
    setup do
      @server_1 = TestServer.start(8101, "server 1 content")
      @server_2 = TestServer.start(8102, "server 2 content")
    end

    should "write files for each server to directory" do
      test_dir = Dir.tmpdir + "/build_poller_test.#{Time.now.to_f}"
      Dir.mkdir test_dir
      poller = BuildPoller.new(["http://localhost:8101/", "http://localhost:8102"], test_dir)
      poller.poll_once

      assert_equal "server 1 content", File.read(test_dir + "/localhost.8101")
      assert_equal "server 2 content", File.read(test_dir + "/localhost.8102")
    end

    teardown do
      @server_1.stop
      @server_2.stop
    end
  end
end

class TestServer
  def self.start(port, contents)
    server = new(port, contents)
    server.start
    server
  end

  def initialize(port, contents)
    @port = port
    @contents = contents
  end

  def start
    @pid = fork do
      serv, sock = TCPServer.new(@port), nil
      begin
        sock = serv.accept_nonblock
      rescue Errno::EAGAIN, Errno::ECONNABORTED, Errno::EPROTO, Errno::EINTR
        IO.select([serv])
        retry
      end

      sock.gets # read http request
      sock.write "HTTP/1.0 200 Success\r\n\r\n"
      sock.write @contents
      sock.close
    end
    # give child process time to aquire socket and listen
    sleep 0.01
  end

  def stop
    Process.kill("TERM", @pid)
    Process.wait(@pid)
  end
end

