module Pkg
    class Ger
        attr_accessor :halwa, :build_halwa
        CONFIG =  { os: %w(trusty jessie centos7), branch: '1.5', git: 'https://github.com/megamsys/vertice.git' }.freeze

        PRODUCT = {
            name: 'vertice',
            description: '
            Description: Omnischeduler engine for Megam Vertice which provides scheduling
            function for MegamVertice. This is the core engine that works on top of a
            messaging layer Nsqd (nsq.io) and connects to an opensource database
            ScyllaDB 1.x or compatible cassandra 3.x.
            .
            This is the core engine that provides real time log streaming, processing requests
            sent from Vertice gateway, processing events for billing, user alerts and integration
            to billing systems like WHMCS.
            .
            This package contains a golang based server that is the core engine for MegamVertice.
            ',
            
            dependencies: 'verticecommon, unzip'

        }.freeze

        def os_ok!(build_os)
            raise "--- You have two horns. \nUnsupported os: #{build_os}" unless CONFIG[:os].include? build_os
        end
    end
end
