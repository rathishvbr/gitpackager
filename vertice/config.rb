require "../version.rb"
require "colorize"

module Pkg
    class Config
        include Pkg::Version

        PACKAGE = {
            package: VERTICE,
            description: %Q[Description: Core engine which provides scheduling,
            provisioning, realtime log streaming, events handling functions for #{BASIC[:product]}.
            Works on top of a messaging layer NSQ (nsq.io) with interface to an opensource database
            cassandra 3.7],
            category: 'cloud',
            dependencies: "#{COMMON}",
            #The git config differs for each of the project, hence we have them in the individual confs.
            #git_org is needed as golang uses namespace during compiling
            git: 'https://github.com/megamsys/vertice.git',
            git_org: 'github.com/megamsys',
            branch: '1.5',

            #The service name to start
            systemd_service: "#{VERTICE}.service",
            upstart_service: "#{VERTICE}"
          }.freeze

          puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:green).bold

    end
end
