ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)
abort('DATABASE_URL environment variable is set') if ENV['DATABASE_URL']

require 'rspec/rails'
require 'webmock/rspec'
require 'vcr'
require 'database_cleaner'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

module Features
  # Extend this module in spec/support/features/*.rb
  include Formulaic::Dsl
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_request do |request|
    request.method == :delete
  end
  c.filter_sensitive_data('<GITHUB_TOKEN>') { ENV['GITHUB_API_TOKEN'] }
end

RSpec.configure do |config|
  config.include Features, type: :feature
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL, type: :request
  config.include BackgroundJobs
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
  config.before(:suite) do
    WebMock.disable_net_connect!(allow_localhost: true)
    DatabaseCleaner.clean_with :truncation
    begin
      DatabaseCleaner.start
    ensure
      DatabaseCleaner.clean
    end
  end
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.after(:suite) do
    WebMock.allow_net_connect!
  end
  config.render_views

  config.around(:each, type: :controller) do |example|
    run_background_jobs_immediately do
      example.run
    end
  end
end

ActiveRecord::Migration.maintain_test_schema!
