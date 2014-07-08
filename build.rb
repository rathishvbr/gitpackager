require 'thor'
require 'highline'

class Distro < Thor                                              # [1]
  package_name "Build"                                           # [2]
  map "-L" => :list                                              # [3]

  desc "build", "build all of the available apps"                # [4]
  method_options :clean => :boolean, :name => :string            # [5]

  def build(name)
    package_name = options[:name]

    if options.clean?
      # iterate over all the directories and kill off rake scripts
    end
    # other code
  end

  desc "list [SEARCH]", "list all of the available packages, limited by SEARCH"
  def list(search="")
    # list everything
  end
end
