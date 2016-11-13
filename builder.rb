require 'rake'
require 'fileutils'
require 'colorize'
require '../scripter.rb' #As this is called from one level down from Rakefile we do ../

module Pkg
    class Builder

        attr_accessor :distro_dir
        attr_accessor :distro_build_dir
        attr_accessor :date, :package

        def initialize(distro_dir, distro_build_dir, package, date = Time.now)
            @distro_dir = distro_dir
            @distro_build_dir = distro_build_dir
            @package = package
            @date = date
        end

        def exec
            make
            clone
            #run
        end

        private

        def make
            puts "=> 1. Transform: erb - #{@distro_dir}".colorize(:green).bold
            Rake::FileList[@distro_dir + "/**"].each do |f|
                @scripter = Scripter.new(Pkg::Version::BASIC, @package,IO.read(f))
                @scripter.save(File.join(@distro_build_dir,File.basename(f, '.erb')))
            end if File.exists?(@distro_dir)

            Dir.chdir @distro_build_dir
        end

        ######### cloner.rb
        ######### All these should be a separate class (cloner.rb with a method clone)
        #########
        def git_org_dir
            @package[:package]/src/@package[:git_org]
        end

        def git_org_pkg_dir
            git_org_dir/@package[:package]
        end

        def clone
            puts "=> 2. Clone: git - #{@package[:git]}".colorize(:green).bold

            unless @package[:git]
              puts "   ✘ skip git".colorize(:red)
              return
            end

            FileUtils.mkdir_p git_org_dir
            if !File.exists? git_org_pkg_dir
                Dir.chdir git_org_dir
                system "git clone -b #{@package[:branch]} @package[:git]"
            end
            puts "   ✔ #{@package[:git]}".colorize(:blue)

            Dir.chdir @distro_build_dir
        end
        #############
        ## end cloner.rb :)
        #############

        def run
            puts "=> 3. Execute: g - #{@distro_dir}".colorize(:green).bold
            if File.file?('./g')
                FileUtils.chmod 0755, './g'
                system './g'
            else
                puts "   ✘ skip g - #{@distro_dir}".colorize(:red)
            end
        end
    end
end
