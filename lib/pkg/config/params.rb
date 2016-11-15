module Pkg::Params
    BUILD_PARAMS = [:distro,
        :name,
        :packagin_repo,
        :packaging_release,
        :git_release,
        :packaging_iteration,
    :gpg_key]

    def self.ARGVS
        return {} if ARGV.length <= 2

        cut_args = ARGV.slice(1..-1).map {|s| s.split('=')}.flatten

        Hash[*cut_args].map { |k,v| [k.to_sym, v] }.to_h
    end

end
