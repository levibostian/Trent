# frozen_string_literal: true

require 'command/ssh/ssh'
require 'github/github'
require 'command/sh/sh'
require 'colorize'
require_relative './log'

# Communicate with all of the Trent library with this class.
class Trent
  def initialize(color = :blue)
    Log.fatal('Trent is designed to run on Travis-CI builds. Run it on Travis-CI.') unless ENV['HAS_JOSH_K_SEAL_OF_APPROVAL']

    @color = color
    @sh = Sh.new
  end

  # Configure how to run remote SSH commmands on server.
  def config_ssh(username, host, password = nil)
    @ssh = SSH.new(username, host, password: password)
  end

  # Configure how to communicate with GitHub
  def config_github(api_key)
    @github = GitHub.new(api_key)
  end

  ## Run ssh command
  def ssh(command, fail_non_success = true)
    Log.fatal('You did not configure SSH yet.') unless @ssh

    puts command.colorize(@color)
    result = @ssh.run(command)

    Log.fatal('Command failed with a non 0 exit status.') if !result[:result] && fail_non_success

    result
  end

  # Run local bash command
  def sh(command, fail_non_success = true)
    puts command.colorize(@color)

    result = @sh.run(command)

    unless result[:result]
      if fail_non_success
        Log.fatal('Command failed with a non 0 exit status.')
      else
        Log.warning('Command failed with a non 0 exit status.')
      end
    end

    result
  end

  # Get instance of GitHub class to run commands against GitHub
  def github
    Log.fatal('You did not configure GitHub yet.') unless @github
    @github
  end
end