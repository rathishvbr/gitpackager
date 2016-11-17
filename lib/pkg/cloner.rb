require 'fileutils'
require 'pkg/version'
module Pkg
    class Cloner
       include Pkg::Version
        attr_accessor :package

        def initialize(package)
          @package = package
        end

        def git_org_dir
          if @package[:git_org] == nil
              ".#{BASIC[:home]}"
          else
            @package[:package]+"/src/"+@package[:git_org]
          end
        end

        def git_org_pkg_dir
            git_org_dir+"/"+@package[:package]
        end

        def clone
           cur_dir=Dir.pwd
            puts "=> 2. Clone: git - #{@package[:git]}".colorize(:green).bold
            unless @package[:git]
                puts "   ✘ skip git".colorize(:red)
                return
            end

            FileUtils.mkdir_p git_org_dir
            if !File.exists? git_org_pkg_dir
                Dir.chdir git_org_dir
                system "git clone -b #{@package[:branch]} #{@package[:git]}"
            end
            puts "   ✔ #{@package[:git]}".colorize(:blue)
            Dir.chdir cur_dir

        end
    end
end
