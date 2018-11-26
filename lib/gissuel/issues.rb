module Gissuel
  class Issues 

    TOKEN = ENV["GITHUB_TOKEN"]
    
    def initialize(label, repo, verbose, index)
      @verbose  = verbose
      @label    = label
      @repo     = repo
      @state    = "open"
      @index    = index
    end

    def publish
      handle_issues(desired_issues)
    end

    private

    def client
      @connection ||= Octokit::Client.new(:access_token => TOKEN, 
                                          :auto_paginate => true)
    end

    def my_login
      client.user.login
    end

    def desired_issues
      issues = client.list_issues(
        @repo,
        options = { 
          :assignee => my_login,
          :labels => @label,
          :state => @state
        }
      )

      @index.zero? ? issues : [issues[@index - 1]]
    end

    def handle_issues(issues)
      case issues.count
      when 0
        Gissuel::Log.new("\nGissuel: 👋 ☕ ☺️").grey
      when 1
        if @index.zero? then
          Gissuel::Log.new("👋  there is one issue on your 🍽️.").red
          Gissuel::Log.new("☕  here is quick look at it:\n").grey
          report_issue(issues.first, @index + 1)
        else 
          Gissuel::Log.new("☕  here is quick look at the issue:\n").grey
          report_issue(issues.first, @index)
        end
      else
        Gissuel::Log.new("👋  there are #{issues.count} issues on your 🍽️.").red
        Gissuel::Log.new("☕  here is quick look at these:\n").grey

        issues.each_with_index do |issue, index|
          report_issue(issue, index + 1)
        end
      end
    end

    def report_issue(issue, index)
      Gissuel::Log.new("[#{index}]: #{issue.title}").yellow
      Gissuel::Log.new("URL: #{issue.html_url}").blue
      Gissuel::Log.new("DESCRIPTION: #{issue.body}").grey if @verbose
      Gissuel::Log.new(comments_report(issue)).green
    end

    def comments_report(issue)
      general_info = "No of comments: #{issue.comments} | Updated at: #{issue.updated_at}"

     # comment_autor_requested? ? [general, comment_author(issue)].join(" | ") : general
     issue.comments.nonzero? && @verbose ? [general_info, last_comment_author(issue)].join(" | ") : general_info
    end

    def last_comment_author(issue)
      repo = issue.repository_url
                        .split("/")
                        .last(2)
                        .join("/")

      client.issue_comments(repo, issue.number).last
            .user.login
    end

  end
end
