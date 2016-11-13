require "../version.rb"
require "colorize"

module Pkg
    class Config
        include Pkg::Version

        PACKAGE = {
            package: COMMON,
            description: %Q[This is an empty package that creates the group and user, and the
              base directories  for #{BASIC[:product]}.],
            category: 'cloud'
        }

        puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:cyan).bold

    end
end
