module Pkg
    class Config
        require 'pkg/config/params.rb'
        require 'yaml'
        require 'colorize'

        class << self

            Pkg::Params::BUILD_PARAMS.each do |v|
                attr_accessor v
            end

            def instance_values
                Hash[instance_variables.map { |name| [name[1..-1], instance_variable_get(name)] }]
            end

            def config_from_hash(data = {})
                data.each do |param, value|
                    if Pkg::Params::BUILD_PARAMS.include?(param.to_sym)
                        self.instance_variable_set("@#{param}", value)
                    else
                        warn "Warning - No build data parameter found for '#{param}'. Perhaps you have an erroneous entry in your yaml file?"
                    end
                end
            end

            def config_from_yaml(file)
                build_data = Pkg::Util::Serialization.load_yaml(file)
                config_from_hash(build_data)
            end

            def config(args = { :target => nil, :format => :hash })
                case args[:format]
                when :hash
                    self.config_to_hash
                when :yaml
                    self.config_to_yaml(args[:target])
                end
            end

            def config_to_hash
                data = {}
                Pkg::Params::BUILD_PARAMS.each do |param|
                    data.store(param, self.instance_variable_get("@#{param}"))
                end
                data
            end

            def config_to_yaml(target = nil)
                file = "#{self.ref}.yaml"
                target = target.nil? ? File.join(Pkg::Util::File.mktemp, "#{self.ref}.yaml") : File.join(target, file)
                Pkg::Util::File.file_writable?(File.dirname(target), :required => true)
                File.open(target, 'w') do |f|
                    f.puts self.config_to_hash.to_yaml
                end
                puts target
                target
            end

            def print_config
                self.config_to_hash.each { |k, v| puts "#{k}: #{v}" }
            end


            def default_project_root
                ENV['PROJECT_ROOT'] || File.expand_path(File.join(LIBDIR, ".."))
            end

            def default_packaging_root
                defined?(PACKAGING_ROOT) ? File.expand_path(PACKAGING_ROOT) : File.expand_path(File.join(LIBDIR, ".."))
            end

            def load_default_configs
                default_build_defaults = File.join(@project_root, "build_defaults.yaml")

                [default_build_defaults].each do |config|
                    if File.readable? config
                        self.config_from_yaml(config)
                    else
                        puts "   ✘ skip load #{default_build_defaults}".colorize(:red)
                        @project_root = nil
                    end
                end

                if @project_root
                    puts "   ✔ loaded #{default_build_defaults}".colorize(:blue).bold
                    self.config
                end
            end


            def load_args
                Pkg::Params.ARGVS.each do |k, v|
                    self.instance_variable_set("@#{k}", v)
                end
            end

           def load_defaults
                @project_root   ||= default_project_root
                @packaging_root ||= default_packaging_root
            end

            def string_to_array(str)
                delimiters = /[,\s;]/
                return str if str.respond_to?('each')
                str.split(delimiters).reject { |s| s.empty? }.map { |s| s.strip }
            end
        end
    end
end
