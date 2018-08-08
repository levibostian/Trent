# frozen_string_literal: true

# Conventient methods when working with commands
class Command
  # Takes a hash (paths) and replaces each occurance of the keys with the value within the "command" string.
  # This is used when you have a "docker-compose ... up -d" command and you want to replace all occurances of "docker-compose" with "/opt/bin/docker-compose".
  def self.path_replace(command, paths)
    # I am doing command.split() instead of a simple `gsub()` because I need to replace *whole words* not substrings.
    edited_command = []
    command.split(' ').each do |command_phrase|
      if paths.key? command_phrase
        edited_command.push(paths[command_phrase])
      else
        edited_command.push(command_phrase)
      end
    end

    edited_command.join(' ')
  end
end
