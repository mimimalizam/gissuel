module Gissuel

  class CLI < Thor
    attr_reader :label, :repo

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
    def get
      @label = options[:label]
      @repo = options[:repo]

      Gissuel::Issues.new(label, repo).publish
    end

    desc "version", "Prints the haskii version info"
    def version
      puts "Gissuel version #{Gissuel::VERSION}"
    end
    map %w(-v --version) => :version

  end

end
