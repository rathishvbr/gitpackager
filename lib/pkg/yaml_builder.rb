
require 'erb'
require 'colorize'

module Pkg
    class YamlBuilder
        include ERB::Util

        attr_accessor :basic
        attr_accessor :package
        attr_accessor :date
        attr_accessor :template

        def initialize
            @basic    = ""
            @package  = ""
            @date     = ""
            @template = IO.read("./build_defaults.yaml.erb")
        end

        def render
              ERB.new(@template).result(binding)
        end

        def save
            FileUtils.rm("build_defaults.yaml") if Pkg::Util::File.exists?("build_defaults.yaml")
            
            File.open("build_defaults.yaml", 'w+') do |f|
                puts "   ✔ #{f.path}".colorize(:blue)
                f.write(render)
            end
        end
    end
end
