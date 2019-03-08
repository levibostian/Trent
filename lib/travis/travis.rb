# frozen_string_literal: true

require 'travis'
require 'travis/pro' # For private repos
require_relative '../log'

# Functions to run on Travis
class TravisCI
  def initialize(params = {})
    Log.fatal('Cannot run commands against Travis when not running on a Travis server') unless TravisCI.running_on_travis?

    @private = params.fetch(:private_repo, false)
    @travis_token = params.fetch(:api_key)

    authenticate
  end

  # If currently running on a Travis CI machine
  def self.running_on_travis?
    ENV['HAS_JOSH_K_SEAL_OF_APPROVAL']
  end

  # If CI job running on a pull request
  def self.pull_request?
    ENV['TRAVIS_PULL_REQUEST'].to_s == 'true'
  end

  # If the current job is a pull request, this will determine if the previous build for the current branch was successful or not.
  # Note: An exception will be thrown if not in a pull request.
  def branch_build_successful?
    Log.fatal('Cannot determine if branch build was successful if not running on a pull request') unless TravisCI.pull_request?

    travis_repo = repo
    original_branch = ENV['TRAVIS_PULL_REQUEST_BRANCH']

    travis_repo.branch(original_branch).green?
  end

  # Get repository from Travis
  def repo
    if @private
      Travis::Pro::Repository.find(ENV['TRAVIS_REPO_SLUG'])
    else
      Travis::Repository.find(ENV['TRAVIS_REPO_SLUG'])
    end
  end

  # If the previous build on current branch failed on Travis, skip this build too.
  def fail_if_pr_branch_build_failed
    return unless TravisCI.pull_request?

    Log.warning('Checking if previous build for this branch was successful on Travis...')

    Log.fatal('Skipping running command because previous build for branch failed.') unless branch_build_successful?
  end

  private

  def authenticate
    if @private
      Travis::Pro.access_token = @travis_token
    else
      Travis.access_token = @travis_token
    end
  end
end
