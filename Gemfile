source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'jsbundling-rails'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1', '>= 7.1.3.2'
gem 'devise'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.7', '>= 1.7.3'
# gem 'pg'
# Use Puma as the app server
gem 'puma', '~>6.4.2'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'turbo-rails', '~> 2.0', '>= 2.0.5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
#gem 'stimulus-rails'
# gem 'bcrypt', '~> 3.1.7'
gem 'stimulus-rails', '~> 1.3', '>= 1.3.3'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'faker', '~> 3.4', '>= 3.4.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.9'
  gem 'better_errors', '~> 2.6'
  gem 'rubocop', '~> 1.63', '>= 1.63.3', require: false
  gem 'rubocop-rails', '~> 2.24', '>= 2.24.1', require: false
  gem 'rubocop-performance', '~> 1.21'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '>= 2.15'
  # gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  # gem 'webdrivers'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# SCSS/CSS Framework
gem 'bulma-rails', '~> 1.0', '>= 1.0.1'

gem 'simple_form', '~> 5.0', '>= 5.0.2'

gem 'slim', '~> 5.2.1', '>= 4.0.1'

gem 'slim-rails', '~> 3.2'

gem 'image_processing'

# SCSS/SASS processing
gem "dartsass-rails", "~> 0.5.0"

gem 'sprockets-rails'
