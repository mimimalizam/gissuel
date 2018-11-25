module Gissuel

  class CLI < Thor
    attr_reader :label, :repo, :body, :index

    desc "get", "will print out list of issues assigned to you"

    long_desc <<-LONGDESC
      Searches for issues assigned to you.
      It respects --label and --repo when specified
      Prints these in your terminal.
      Make sure to export GITHUB_TOKEN variable to environment.\n
      
      Example: \n
       > $ gissuel get --label planned --repo semaphoreci/semaphore
    LONGDESC

    option :label
    option :repo
    option :body, :lazy_default => true, :default => false, :type => :boolean
    option :index, :default => 0, :type => :numeric
    def get
      @label = options[:label]
      @repo  = options[:repo]
      @body  = options[:body]
      @index = options[:index]

      Gissuel::Issues.new(label, repo, body, index).publish
    end

    desc "version", "Prints the haskii version info"
    def version
      puts "Gissuel version #{Gissuel::VERSION}"
    end
    map %w(-v --version) => :version

  end

end
