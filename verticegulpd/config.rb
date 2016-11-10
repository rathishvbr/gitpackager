require "../version.rb"
require "colorize"

module Pkg
  class Config
    include  Pkg::Version

    attr_accessor :halwa, :build_halwa

    CONFIG =  { os: %w(trusty xenial centos7),
                branch: 'master',
                git: "https://github.com/megamsys/gulp.git" }

    PRODUCT = {
      name: GULPD,
      description: ""
    }

    puts "=> Packaging: [#{PRODUCT[:name]} #{VERSION}:#{ITERATION}]".colorize(:blue)

    def os_ok!(build_os)
      raise "--- You have two horns. \nUnsupported os: #{build_os}" unless CONFIG[:os].include? build_os
    end
  end
end
