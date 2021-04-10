require 'database_cleaner'

RSpec.configure do |config|
  # config.before(:suite) do
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # config.before(:each) do
  #   # DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.start
  # end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # config.after(:all) do
  #   DatabaseCleaner.clean_with(:truncation)
  # end
end
