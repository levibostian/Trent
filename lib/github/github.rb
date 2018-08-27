# frozen_string_literal: true

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
    # https://docs.travis-ci.com/user/environment-variables/#convenience-variables
    # Must check if 'false' because `TRAVIS_PULL_REQUEST` always has a value.
    if ENV['TRAVIS_PULL_REQUEST'].to_s == 'false'
      Log.warning("Not in pull request, skipping GitHub comment. Message: #{message}")
      return
    end

    result = comment_on_pull_request(message)

    if !result[:successful]
      puts "Status code: #{result[:status_code]}"
      puts "Body: #{result[:body]}"
      Log.fatal('Commenting on GitHub pull request failed.')
    else
      Log.success('Successfully commented on GitHub pull request.')
    end
  end

  private

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
