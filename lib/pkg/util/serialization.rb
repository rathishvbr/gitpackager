module Pkg::Util::Serialization
  class << self

    def load_yaml(file)
      require 'yaml'
      file = File.expand_path(file)
      begin
        input_data = YAML.load_file(file) || {}
      rescue
        fail "There was an error loading data from #{file}."
      end
      input_data
    end
  end
end
