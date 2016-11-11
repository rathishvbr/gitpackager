require "../version.rb"
require "colorize"

module Pkg
    class Config
        include Pkg::Version

        PACKAGE = {
            package: 'verticecommon',
            description: %Q[This is an empty package that creates the group and user, and the
              base directories  for #{BASIC[:product]}.],
            category: 'infrastructure'
        }

        puts "=> Packaging: [#{PACKAGE[:package]} #{BASIC[:version]}:#{BASIC[:iteration]}]".colorize(:green).bold

        ## just a hack call to version's distro
        ## I don't think this is correct as every config.rb will have that.
        def self.setup_distro(os)
            Pkg::Version.distro(os)
        end

        def self.build_dir
          Pkg::Version::BUILD
        end

        def self.distro_dir
            Pkg::Version.distro_dir
        end

        def self.distro_build_dir
            Pkg::Version.distro_build_dir
        end

    end
end
