module MegamPkg
  class Ger
    attr_accessor :halwa, :build_halwa
    CONFIG =  { os: %w(trusty jessie centos7), branch: 'master', name: 'verticecadvisor', :git => "https://github.com/megamsys/cadvisor.git" }

    def os_ok!(build_os)
      raise "--- You have two horns. \nUnsupported os: #{build_os}" unless CONFIG[:os].include? build_os
    end
  end
end
