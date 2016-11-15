require 'colorize'

module Pkg::Util::Execution

    class << self

        def success?(statusobject = $?)
            return statusobject.success?
        end

        def ex(command, debug = false)
            puts "   ✔ exec #{command}".colorize(:blue).bold if debug
            ret = `#{command}`
            unless Pkg::Util::Execution.success?
                raise RuntimeError
            end

            if debug
                puts "   ✔ exec returned \n#{ret}".colorize(:blue).bold if debug
            end

            ret
        end

        def retry_on_fail(args, &blk)
            success = FALSE

            if args[:times].respond_to?(:times) and block_given?
                args[:times].times do |i|
                    if args[:delay]
                        sleep args[:delay]
                    end

                    begin
                        blk.call
                        success = TRUE
                        break
                    rescue
                        puts "   ✘ An error was encountered evaluating block. Retrying..".colorize(:red)
                    end
                end
            else
                fail "retry_on_fail requires and arg (:times => x) where x is an Integer/Fixnum, and a block to execute"
            end
            fail "Block failed maximum of #{args[:times]} tries. Exiting.." unless success
        end
    end
end
