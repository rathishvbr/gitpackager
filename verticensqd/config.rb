require "../version.rb"
require "colorize"

module Pkg
    class Config
        include Pkg::Version

        PACKAGE = {
            package: NSQD,
            description: %Q[Description: A realtime distributed messaging platform
            NSQ (nsq.io)  for #{BASIC[:product]}.],
            category: 'cloud',

            # download the tar binary
            tar: 'https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.3.8.linux-amd64.go1.6.2.tar.gz',

            #The service name to start
            systemd_nsqd_service: 'nsqd.service',
            systemd_nsqlookupd_service: 'nsqlookupd.service',
            systemd_nsqadmin_service: 'nsqadmin.service',
            
            upstart_nsqd_service: 'nsqd',
            upstart_nsqlookupd_service: 'nsqlookupd',
            upstart_nsqadmin_service: 'nsqadmin'
          }.freeze

          puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:green).bold

    end
end
