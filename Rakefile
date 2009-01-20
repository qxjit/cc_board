require 'rake'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
  t.libs += ['test']
end

task :start do
  sh "nohup /usr/bin/env ruby cc_board.rb -e production > /dev/null &"
  sh "nohup /usr/bin/env ruby build_poller.rb > /dev/null &"
end

task :stop do
  sh "ps ax | grep -E 'ruby (cc_board|build_poller)' | awk '{print $1}' | xargs kill"
end

task :restart => [:stop, :start]
