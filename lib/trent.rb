# frozen_string_literal: true

require 'command/ssh/ssh'
require 'github/github'
require 'travis/travis'
require 'command/sh/sh'
require 'colorize'
require_relative './log'
require 'command/command'

# Communicate with all of the Trent library with this class.
class Trent
  # Initialize Trent instance.
  # color - Color of shell output you want Trent to use.
  # local - Run Trent locally on your own machine instead of a CI server.
  def initialize(params = {})
    running_local = params.fetch(:local, false)
    Log.fatal('Trent is designed to run on Travis-CI builds. Run it on Travis-CI.') unless TravisCI.running_on_travis? || running_local

    @color = params.fetch(:color, :blue)
    @sh = Sh.new

    @paths = {}
  end

  # Configure how to run remote SSH commmands on server.
  def config_ssh(username, host, options = nil)
    @ssh = SSH.new(username, host, options)
  end

  # Configure how to communicate with GitHub
  def config_github(api_key)
    @github = GitHub.new(api_key)
  end

  # Configure how to communicate with Travis
  def config_travis(api_key, private_repo)
    @travis = TravisCI.new(api_key: api_key, private_repo: private_repo)
  end

  # While working with bash commands, some commands are not added to the path. That's annoying.
  # Convenient method to assign a command to a path for replacing.
  # Example:
  # ci.path("docker-compose", "/opt/bin/docker-compose")
  # Now, when you use ci.sh("docker-compose -f ... up -d"), it will run "/opt/bin/docker-compose -f ... up -d" instead.
  def path(command, path)
    @paths[command] = path
  end

  ## Run ssh command
  def ssh(command, fail_non_success: true)
    command = Command.path_replace(command, @paths)
    Log.fatal('You did not configure SSH yet.') unless @ssh

    puts command.colorize(@color)
    result = @ssh.run(command)

    process_shell_result(result, fail_non_success)

    result
  end

  # Run local bash command
  def sh(command, fail_non_success: true)
    command = Command.path_replace(command, @paths)
    puts command.colorize(@color)

    result = @sh.run(command)
    process_shell_result(result, fail_non_success)

    result
  end

  # Get instance of GitHub class to run commands against GitHub
  def travis
    Log.fatal('You did not configure Travis yet.') unless @travis
    @travis
  end

  # Get instance of GitHub class to run commands against GitHub
  def github
    Log.fatal('You did not configure GitHub yet.') unless @github
    @github
  end

  private

  def process_shell_result(result, fail_non_success)
    return if result[:result]

    if fail_non_success
      Log.fatal('Command failed with a non 0 exit status.')
    else
      Log.warning('Command failed with a non 0 exit status.')
    end
  end
end
