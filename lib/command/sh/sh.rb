# frozen_string_literal: true

require 'open3'

# Run bash commands locally on machine.
class Sh
  def initialize; end

  # Run a bash command locally.
  def run(command)
    output = ''
    exit_status = nil
    Open3.popen3(command) do |_stdin, stdout, stderr, wait_thr|
      stdout.each_line do |line|
        puts line
        output += line
      end
      stderr.each_line do |line|
        puts line
        output += line
      end
      exit_status = wait_thr.value
      return { output: output, result: exit_status.success? }
    end
  end
end
