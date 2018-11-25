module Gissuel
  class Issues 

    TOKEN = ENV["GITHUB_TOKEN"]
    
    def initialize(label, repo, body)
      @label = label
      @repo  = repo
      @state = "open"
      @body  = body
    end

    def publish
      handle_gh_response(assigned_issues)
    end

    private

    def client
      @connection ||= Octokit::Client.new(:access_token => TOKEN, 
                                          :auto_paginate => true)
    end

    def my_login
      client.user.login
    end

    def assigned_issues
      client.list_issues(
        @repo,
        options = { 
          :assignee => my_login,
          :labels => @label,
          :state => @state
        }
      )
    end

    def handle_gh_response(issues)
      case issues.count
      when 0
        Gissuel::Log.new("\nGissuel: 👋 ☕ ☺️").grey
      when 1
        Gissuel::Log.new("👋  there is one issue on your 🍽️.").red
        Gissuel::Log.new("☕  here is quick look at it:\n").grey

        report_issue(issues[0])
      else
        Gissuel::Log.new("👋  there are #{issues.count} issues on your 🍽️.").red
        Gissuel::Log.new("☕  here is quick look at these:\n").grey

        issues.each do |i|
          report_issue(i)
        end
      end
    end

    def report_issue(issue)
      Gissuel::Log.new("TITLE: #{issue.title}").yellow
      Gissuel::Log.new("URL: #{issue.html_url}").blue
      Gissuel::Log.new("BODY: #{issue.body}").grey if @body
      Gissuel::Log.new("No of comments: #{issue.comments} | Updated at: #{issue.updated_at}\n").green
    end

  end
end
