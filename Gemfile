source "https://rubygems.org"

ruby "2.2.3"

gem "airbrake"
gem "autoprefixer-rails"
gem "bourbon", "~> 4.2.0"
gem "coffee-rails", "~> 4.1.0"
gem "delayed_job_active_record"
gem "flutie"
gem "high_voltage"
gem "jquery-rails"
gem "neat", "~> 1.7.0"
gem "newrelic_rpm", ">= 3.9.8"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "title"
gem "uglifier"
gem 'haml-rails', '~> 0.9.0'
gem 'octokit', '~> 4.2.0'
gem 'friendly_id', '~> 5.1.0'

group :development do
  gem "quiet_assets"
  gem "refills"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", require: false
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  # gem "i18n-tasks" currently conflicts with rubocop. not needed just yet.
  gem "pry-rails"
  gem "rspec-rails", "~> 3.3.0"
  gem 'rubocop', '~> 0.35.1', require: false
  gem 'rspec_junit_formatter', '0.2.2' # for circleci
  gem 'vcr', '~> 3.0.0'
  gem 'capybara', '~> 2.5.0'
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
end
