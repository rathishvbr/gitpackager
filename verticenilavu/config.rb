require "../version.rb"
require "colorize"

module Pkg
    class Config
        include Pkg::Version

        PACKAGE = {
            package: NILAVU,
            description: %Q[Description: Analyzes resource usage and performance characteristics of
            running containers/machine for #{BASIC[:product]}.],
            category: 'cloud',

            dependencies: "#{Pkg::Version::COMMON}, cgroup-bin",

            # download the tar binary
            tar: 'https://s3.amazonaws.com/megam/cadvisor',

            #The service name to start
            systemd_service: 'cadvisor.service',
            upstart_service: 'cadvisor'
          }.freeze

          puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:green).bold

    end
end
