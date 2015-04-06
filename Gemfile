source "https://rubygems.org"
# For heroku
ruby '2.0.0'
# Heroku
gem "rails", "4.0.2"

gem "pg", :group => :production
gem "mysql2", :group => :development
#gem "pg" #, :require => "pg"

# Compressor of JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.0.0"

# Use jQuery as the JavaScript library
gem "jquery-rails"

# User authentication
gem "devise", "3.2.2"

gem "omniauth-facebook"
gem "kaminari"
gem "ransack"
gem "dynamic_form"

group :test, :development do
  gem "rspec-rails"
  gem "debugger"
  gem "awesome_print"
end

group :development do
  gem "chronic"
  #gem "admin_view"
end

group :test do
#  gem "factory_girl_rails"
  gem 'factory_girl_rails', :require => false
  gem "cucumber-rails", :require => false
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem "capybara"
  gem "shoulda"
  gem "email_spec"
end

group :production, :development do
  gem "thin"
end

gem 'rails_12factor', group: :production

gem 'haml'
gem 'fullcalendar-rails'
gem 'therubyracer'

#gem "open-uri" #ruby core
gem "nokogiri"
gem "json"
