require "../version.rb"
require "colorize"

module Pkg
    class Config
        include Pkg::Version

        PACKAGE = {
            package: VNC,
            description: %Q[Nodejs based VNC serverfor #{BASIC[:product]}],

            category: 'cloud',
            # download the tar binary
            git: 'https://github.com/megamsys/vnc_server',
            branch: '1.5',

            #The service name to start
            systemd_service: "#{VNC}.service",
            upstart_service: "#{VNC}"
          }.freeze

          puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:green).bold

    end
end
