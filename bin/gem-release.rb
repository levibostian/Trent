require 'trent'

ci = Trent.new()

ci.sh("printf '%s\n%s ' '---' ':rubygems_api_key:' > ~/.gem/credentials")
ci.sh("printf $RUBYGEMS_KEY >> ~/.gem/credentials")
ci.sh("chmod 0600 ~/.gem/credentials")

ci.sh("bundle exec rake publish")