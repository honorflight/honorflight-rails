source 'https://rubygems.org'

gem 'dotenv-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Attachments
gem 'carrierwave-aws'
gem 'carrierwave'

# Flight Notifications
gem 'twilio-ruby'


# Encryption
gem 'attr_encrypted', github: 'attr-encrypted/attr_encrypted'

# Active Admin
gem 'devise'
gem 'activeadmin', github: 'activeadmin'
gem 'autoprefixer-rails', "~> 4.0.2.2"
gem 'responders',  "~> 2.0"
gem 'draper'
# gem 'inherited_resources', github: 'josevalim/inherited_resources', branch: 'rails-4-2'

gem 'delayed_job_active_record'
gem 'sucker_punch'
gem 'slim-rails'

# PDF Generation
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'wkhtmltopdf-heroku', group: :production

#heroku
gem 'rails_12factor', group: :production
gem 'thin'

# process runner
gem 'sidekiq'
gem 'sinatra', require: false

gem 'virtus'

gem 'redcarpet'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'selenium-cucumber', require: false
  gem "launchy", "~> 2.1.2"
  gem 'shoulda-callback-matchers', '~> 1.1.1'
end

group :development do
  gem "better_errors"
  # gem "meta_request"
  gem "quiet_assets"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry'
  gem 'pry-remote'
  gem "faker"
  # gem "poltergeist"
  gem "pry-nav"
  gem "pry-rails"
  gem "pry-stack_explorer"
  gem "pry-theme"
  # gem "rubocop"
  gem "spring-commands-rspec"
  gem 'coercible'
  gem 'seed_dump'
  gem "fakeweb"

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails'
  gem 'factory_girl_rails'

  # Security
  gem 'brakeman', require: false
end

ruby '2.1.2'

