module MegamPkg
  class Ger
    CONFIG =  { os: %w(trusty precise jessie centos7), branch: '0.8', name: 'megamnilavu' }

    def os_ok!(build_os)
      raise "--- You have two horns. \nUnsupported os: #{build_os}" unless CONFIG[:os].include? build_os
    end
  end
end
