source "https://rubygems.org"

ruby '2.0.0'

gem "rails", "4.0.2"
gem "pg"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "jquery-rails"
gem "devise", "3.2.2"
gem "omniauth-facebook"
gem "kaminari"
gem "ransack"
gem "dynamic_form"
gem 'rails_12factor', group: :production
gem 'slim'
gem 'fullcalendar-rails'
#gem 'therubyracer'
#gem "open-uri" #ruby core
gem "nokogiri"
gem "json"
gem "awesome_print"

group :test, :development do
  gem "rspec-rails"
  gem "awesome_print"
  gem "pry"
  gem "pry-nav"
end

group :development do
  gem "chronic"
end

group :test do
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