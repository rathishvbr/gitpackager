require 'thor'
require 'highline'

class Deploy < Thor                                               # [1]
  package_name "Deploy"                                           # [2]

  desc "push", "push all of the built packages"                   # [4]
  method_options :clean => :boolean, :name => :string             # [5]

  def push(name)
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
