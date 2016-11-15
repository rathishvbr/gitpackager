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
            git: 'https://github.com/megamsys/meg',
            branch: '1.5',

            #The cli name to build
            cli: "#{MEG}"      
          }.freeze

          puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:green).bold

    end
end
