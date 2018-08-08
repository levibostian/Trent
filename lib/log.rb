# frozen_string_literal: true

require 'colorize'

# Convenient class to log to console in certain ways
class Log
  # Fatal error. We should not move forward.
  def self.fatal(message)
    abort("FATAL: #{message}".colorize(:red))
  end

  # Warning we want to show to the user.
  def self.warning(message)
    puts "Warning: #{message}".colorize(:yellow)
  end

  def self.success(message)
    puts "Success: #{message}".colorize(:green)
  end
end
