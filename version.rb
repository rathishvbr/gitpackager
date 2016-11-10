module Pkg
    module Version
        attr_accessor :os

        ## check if  colorize gem is installed.
        unless Gem::Specification::find_all_by_name('colorize').any?
            puts 'Missing gem: colorize.'
            puts 'Run "bundle install"'
            exit
        end

        ## All of these can be loaded using a YAMLLoader (build_data.yml)
        ## Default operation system supported
        SUPPORTED_OS =  { os: %w(trusty xenial centos7)}

        ### HOME and the build directory
        HOME   = "/usr/share/megam"
        BUILD  = "build"

        # basic fields used across the packager
        # change the name to your own downstream fork. eg: virtengine
        BASIC = {
            product:    "MegamVertice".freeze,
            version:    "1.5".freeze,
            iteration:  "3".freeze,
            license:    "MIT".freeze,
            home:       "#{HOME}",
            vendor:     "Megam Systems".freeze,
            maintainer: "Megam Humans <humans@megam.io>".freeze,
            url:        "https://docs.megam.io".freeze
        }

        # short package names.
        # change the name to your own downstream fork. eg: virtenginecommon
        COMMON    = "verticecommon".freeze
        NILAVU    = "verticenilavu".freeze
        GATEWAY   = "verticegateway".freeze
        NSQD      = "verticensqd".freeze
        VERTICE   = "vertice".freeze
        GULPD     = "verticegulpd".freeze
        VNC       = "verticevnc".freeze

        # set the ditro and the distro build directory if its the supported os.
        def self.distro(os)
            @os = os
        end

        def self.distro_dir
          @os
        end

        def self.distro_build_dir
            (BUILD + "/" + self.distro_dir) if self.supported_os?
        end

        private

        def self.supported_os?
            raise "=> Unsupported OS: #{@os}" unless SUPPORTED_OS[:os].include? @os
            true
        end
    end
end
