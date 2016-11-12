require 'erb'
require 'colorize'

module Pkg
    class Scripter
        include ERB::Util

        attr_accessor :basic
        attr_accessor :package
        attr_accessor :date
        attr_accessor :template

        def initialize(basic, package, template, date = Time.now)
            @basic    = basic
            @package  = package
            @date     = date
            @template = template
        end

        def render
              ERB.new(@template).result(binding)
        end

        def save(target)
            File.open(target, 'w+') do |f|
                puts "   ✔ #{f.path}".colorize(:blue)
                f.write(render)
            end
        end
    end
end
