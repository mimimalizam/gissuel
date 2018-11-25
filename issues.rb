#!/bin/bash ruby

require 'octokit'

class Log

  def initialize(text)
    @text = text
  end

  def colourize(colour_code)
    "\e[#{colour_code}m#{@text}\e[0m"
  end

  def red
    puts colourize(31)
  end

  def green
    puts colourize(32)
  end

  def yellow
    puts colourize(33)
  end

  def grey
    puts colourize(37)
  end

  def blue
    puts colourize(34)
  end

end

label = ARGV[0]
repo  = ARGV[1]
c = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'], :auto_paginate => true)
my_login = c.user.login

mine_issues = c.list_issues(repo, 
                            options = {
                                       :assignee => my_login, 
                                       :labels => label,
                                       :state => "open"
                                      })

if mine_issues.count == 0 then
  Log.new("\nGissuel: 👋 ☕ ☺️").grey
else
  Log.new("👋  there are #{mine_issues.count} #{label}s issues on your 🍽️.").red
  Log.new("☕  here is quick look at these:\n").grey

  mine_issues.each do |i|
    Log.new("TITLE: #{i.title}").yellow
    Log.new("URL: #{i.html_url}").blue
    Log.new("BODY: #{i.body}").grey
    Log.new("No of comments: #{i.comments} | Updated at: #{i.updated_at}\n").green
  end
end
