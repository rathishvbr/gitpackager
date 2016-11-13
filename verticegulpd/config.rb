require "../version.rb"
require "colorize"

module Pkg
    class Config
        include Pkg::Version

        ### DOWNSTREAM FORKS: Please configure (git:, git_org:, systemd_service:, upstart_service:) to whitelable builds

        PACKAGE = {
            package: GULPD,
            description: %Q[Description: Agent which provides instrumentation,
            provisioning, realtime log streaming, events handling functions for #{BASIC[:product]}.
            Works on top of a messaging layer NSQ (nsq.io) with interface to an opensource database
            cassandra 3.7 or ScyllaDB 1.x.],
            category: 'cloud',
            dependencies: "#{COMMON}",

            #The git config differs for each of the project, hence we have them in the individual confs.
            #git_org is needed as golang uses namespace during compiling
            git: 'https://github.com/megamsys/gulp.git',
            git_org: 'github.com/megamsys',
            branch: '1.5',

            #The service name to start
            systemd_service: "#{GULPD}.service",
            upstart_service: "#{GULPD}",
            #Turn this flag on if you don't want to upload to cloud storage like S3
            skip_upload: false
          }.freeze

          puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:green).bold

    end
end
