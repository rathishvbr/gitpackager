require "../version.rb"
require "colorize"

module Pkg
    class Config
        include Pkg::Version

        PACKAGE = {
            package: GATEWAY,
            description: %Q[Description: RESTful API gateway using HMAC authentication
              Vertice gateway connects to an opensource database ScyllaDB or,
              compatible cassandra 3.x for #{BASIC[:product]}.],
            category: 'cloud',

            dependencies: "#{Pkg::Version::COMMON}",

            git: 'https://github.com/megamsys/vertice_gateway',
            branch: '1.5'

            #The service name to start
            systemd_service: ' #{BASIC[:product].service',
            upstart_service: ' #{BASIC[:product]'
          }.freeze

          puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:green).bold

    end
end
