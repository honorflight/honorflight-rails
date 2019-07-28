source 'https://rubygems.org'

gem 'dotenv-rails'

gem 'rake', '< 11.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 1.0'
# Use SCSS for stylesheets
gem 'sass'
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
gem 'turbolinks', '~> 2.5.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Upgrade
gem 'sprockets', '< 4.0'
gem 'sprockets-rails', '= 2.3.1'

# Attachments
gem 'carrierwave-aws', "~> 0.5.0"
gem 'carrierwave', '~> 0.10.0'

# Flight Notifications
gem 'twilio-ruby', '~> 4.0.0'


# Encryption
gem 'attr_encrypted', '~> 1.3.0' #, github: 'attr-encrypted/attr_encrypted'
# gem 'attr_encrypted', "~> 3.0.0"

# Active Admin
# gem "devise", "~> 3.4.1"
gem 'devise', :git => "git://github.com/plataformatec/devise.git", :branch => "3-stable"
gem 'activeadmin', github: 'activeadmin'
gem 'autoprefixer-rails', '~> 4.0.2.2'
gem 'responders',  '~> 2.0'
gem 'draper', '1.4.0'
gem 'inherited_resources', github: 'josevalim/inherited_resources'#, branch: 'rails-4-2'

gem 'delayed_job_active_record', '4.0.3'
gem 'timers', '= 4.1.2'
gem 'sucker_punch', '~> 1.5'
gem 'slim-rails', '3.0.1'

# PDF Generation
gem 'wicked_pdf', '0.11.0'
gem 'wkhtmltopdf-binary', '0.9.9.3'
gem 'wkhtmltopdf-heroku', '2.12.2.1', group: :production

#heroku
gem 'rails_12factor', '0.0.3', group: :production
gem 'thin', '1.6.3'

# process runner
gem 'sidekiq', '3.3.4'
gem 'sidekiq-failures', '0.4.4'
gem 'sinatra', '1.4.6', require: false

gem 'virtus', '1.0.4'

gem 'redcarpet', '3.2.2'

gem "paranoia", "~> 2.0"

# Security fixes - remove on broaded update
gem "rack-protection", ">= 1.5.5"
gem "ffi", ">= 1.9.24"
gem "rubyzip", ">= 1.2.2"
# End security

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
  gem 'shoulda-matchers', '= 2.8', require: false
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
  # gem "quiet_assets"
  
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
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

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails', '= 3.2.2'
  gem 'factory_girl_rails', '4.5.0'

  # Security
  gem 'brakeman', require: false
end

ruby '2.4.6'