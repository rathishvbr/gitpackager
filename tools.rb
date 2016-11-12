require 'fileutils'
require 'colorize'

module Pkg
    class Tools

        ## check if build tools are installed
        def self.check?
          `git version 2>&1` ;  result=$?.success? #go version go1.7.3 linux/amd64
          unless result
            puts "   ✘ git not installed"
           exit
          end

          `go version 2>&1` ;  result=$?.success? #go version go1.7.3 linux/amd64
          unless result
            puts "   ✘ golang not installed"
           exit
          end

          `ruby -v` ; result =$?.success? #ruby version 2.3.1
          unless result
            puts "   ✘ ruby not installed"
            exit
          end
        end

        private

        def compatible_ruby_version?
        end

        def compatible_golang_version?
        end
    end
end
