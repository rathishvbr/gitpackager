require 'fileutils'
require 'colorize'

module Pkg
    class Utils

        ## just a wrapper, with colored printing, equivalent to shell mkdir -p
        def self.mkdir_p(dir)
            puts "   ✔ mkdir -p #{dir}".colorize(:blue)
            FileUtils.mkdir_p dir
        end

        ## just a wrapper, with colored printing, equivalent to shell rmrf
        def self.rmdir(dir)
            puts "   ✔ rmrf #{dir}".colorize(:blue)
            FileUtils.rm_rf dir
        end
    end
end
