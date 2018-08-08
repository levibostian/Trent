require 'net/http'
require 'json'
require_relative '../log'

# Functions to run on GitHub
class GitHub
  def initialize(api_key)
    @api_key = api_key
  end

  # Comment on Pull Request
  def comment(message)
    result = comment_on_pull_request(message)

    if !result[:successful]
      puts "Status code: #{result[:status_code]}"
      puts "Body: #{result[:body]}"
      Log.fatal('Commenting on GitHub pull request failed.')
    else
      Log.success('Successfully commented on GitHub pull request.')
    end
  end

  def comment_on_pull_request(message)
    puts "Commenting on GitHub pull request: #{ENV['TRAVIS_REPO_SLUG']}/#{ENV['TRAVIS_PULL_REQUEST']}"
    uri = URI("https://api.github.com/repos/#{ENV['TRAVIS_REPO_SLUG']}/issues/#{ENV['TRAVIS_PULL_REQUEST']}/comments")

    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req['Authorization'] = "token #{@api_key}"
    req.body = { body: message }.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    res = http.request(req)
    status_code = res.code.to_i
    { status_code: status_code, body: res.body, successful: res.is_a?(Net::HTTPSuccess) && status_code < 400 }
  end
end
