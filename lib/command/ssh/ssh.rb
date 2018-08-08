# frozen_string_literal: true

require 'net/ssh'

# Run SSH commands remotely on a server.
class SSH
  def initialize(username, host, password = nil)
    @username = username
    @host = host
    @password = password
  end

  # Run the SSH command on the server
  def run(command)
    Net::SSH.start(@host, @username, password: @password) do |ssh|
      output = ''
      exit_code = nil
      ssh.open_channel do |channel|
        channel.exec(command) do |_ch, success|
          abort "FAILED: Couldn't execute command #{command}" unless success

          channel.on_data do |_ch, data|
            puts data
            output += data
          end

          channel.on_extended_data do |_ch, _type, data|
            puts data
            output += data
          end

          channel.on_request('exit-status') { |_ch, data| exit_code = data.read_long }
        end
      end
      ssh.loop
      return { output: output, result: exit_code <= 0 }
    end
  end
end
