require 'fileutils'
require 'colorize'

module Pkg
    class Utils

        ## just a wrapper, with colored printing, equivalent to shell mkdir -p
        def self.mkdir_p(dir)
            FileUtils.mkdir_p dir
            puts "   ✔ mkdir -p #{dir}".colorize(:blue).bold
        end

        ## just a wrapper, with colored printing, equivalent to shell rmrf
        def self.rmdir(dir)
            FileUtils.rm_rf dir
            puts "   ✔ rm -rf #{dir}".colorize(:magenta).bold
        end
    end
end
