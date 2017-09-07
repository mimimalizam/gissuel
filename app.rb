require "sinatra"
require "httparty"
require "json"

post "/gateway" do
  message = params[:text].gsub(params[:trigger_word],'').strip

  action, repo = message.split(' ').map {|c| c.strip.downcase}
  repo_url = "https://api.github.com/repos/#{repo}"

  case action
  when "count-issues"
    resp = HTTParty.get(repo_url)
    resp = JSON.parse resp.body
    respond_message "There are #{resp['open_issues_count']} open issues on #{repo}"
  when "show-last-5"
    resp = HTTParty.get(repo_url + "/issues")
    response = JSON.parse(resp.body)
    last_five = response.last(5)
    respond_message "These are last five opened issues:\n" + compose_issues(last_five)
  end
end

def respond_message message
    content_type :json
      { :text => message }.to_json
end

def compose_issues last_five
  last_five.map { |issue| urlize(issue)}
    .join("\n ")
end

def urlize(issue)
  "     <#{issue["html_url"]}|#{issue["title"]}>"
end
