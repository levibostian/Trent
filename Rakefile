# frozen_string_literal: true

task default: %w[build]

task :init do
  sh 'bundle install --path vendor/bundle'
  Rake::Task[:build].invoke
end

task :spec do
  sh 'bundle exec rspec'
end

task :lint do
  sh 'bundle exec rubocop  --auto-correct -c .rubocop.yml'
end

task :build do
  Rake::Task[:spec].invoke
  sh 'rm trent-*.gem || true'
  sh 'gem build trent.gemspec'
end

task :install do
  Rake::Task[:build].invoke
  sh 'gem install trent*.gem'
end

task :publish do
  Rake::Task[:lint].invoke
  Rake::Task[:build].invoke
  sh 'gem push trent*.gem'
end
