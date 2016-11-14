# Utility methods used by the various rake tasks

module Pkg::Util
  require 'erb'
  require 'benchmark'
  require 'base64'
  require 'io/console'
  require 'pkg/util/execution'
  require 'pkg/util/file'
  require 'pkg/util/serialization'
  require 'pkg/util/rake_utils'

  def self.boolean_value(var)
    return TRUE if var == TRUE || ( var.is_a?(String) && ( var.downcase == 'true' || var.downcase =~ /^y$|^yes$/))
    FALSE
  end

  def self.in_project_root(&blk)
    result = nil
    fail "Cannot execute in project root if Pkg::Config.project_root is not set" unless Pkg::Config.project_root

    Dir.chdir Pkg::Config.project_root do
      result = blk.call
    end
    result
  end

  def self.get_var(var)
    self.check_var(var, ENV[var])
    ENV[var]
  end

  def self.check_var(varname, var)
    fail "Requires #{varname} be set!" if var.nil?
    var
  end

  def self.require_library_or_fail(library, library_name = nil)
    library_name ||= library
    begin
      require library
    rescue LoadError
      fail "Could not load #{library_name}. #{library_name} is required by the packaging repo for this task"
    end
  end

  def self.base64_encode(string)
    Base64.encode64(string).strip
  end

  def self.get_input(echo = true)
    fail "Cannot get input on a noninteractive terminal" unless $stdin.tty?

    system 'stty -echo' unless echo
    $stdin.gets.chomp!
  ensure
    system 'stty echo'
  end

  def self.rand_string
    rand.to_s.split('.')[1]
  end

  def self.ask_yes_or_no
    return Pkg::Util.boolean_value(ENV['ANSWER_OVERRIDE']) unless ENV['ANSWER_OVERRIDE'].nil?
    answer = Pkg::Util.get_input
    return true if answer =~ /^y$|^yes$/
    return false if answer =~ /^n$|^no$/
    puts "Nope, try something like yes or no or y or n, etc:"
    Pkg::Util.ask_yes_or_no
  end

  def self.confirm_ship(files)
    $stdout.puts "The following files have been built and are ready to ship:"
    files.each { |file| puts "\t#{file}\n" unless File.directory?(file) }
    $stdout.puts "Ship these files?? [y,n]"
    Pkg::Util.ask_yes_or_no
  end

  def self.pseudo_uri(opts = {})
    options = { path: nil, host: nil }.merge(opts)

    # Prune empty values to determine what is returned
    options.delete_if { |_, v| v.to_s.empty? }
    return nil if options.empty?

    [options[:host], options[:path]].compact.join(':')
  end

  def self.deprecate(old_cmd, new_cmd = nil)
    msg = "!! #{old_cmd} is deprecated."
    if new_cmd
      msg << " Please use #{new_cmd} instead."
    end
    $stdout.puts("\n#{msg}\n")
  end
end
