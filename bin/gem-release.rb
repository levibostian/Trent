# frozen_string_literal: true

require_relative '../lib/trent'

ci = Trent.new
ci.config_github(ENV['DANGER_GITHUB_API_TOKEN'])

ci.sh("printf '%s\n%s ' '---' ':rubygems_api_key:' > ~/.gem/credentials")
ci.sh('printf $RUBYGEMS_KEY >> ~/.gem/credentials')
ci.sh('chmod 0600 ~/.gem/credentials')

ci.sh('bundle exec rake publish')

ci.github.comment("Success! Don't forget to create a git tag and git release.")