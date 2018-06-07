source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'impressionist'
gem 'mysql2'
gem 'breadcrumbs_on_rails'
gem 'kaminari-bootstrap'
gem 'kaminari'
gem 'sitemap_generator'
gem 'httparty'
gem 'rails_12factor'
gem 'autoprefixer-rails'
gem 'bootstrap-sass'#,       '3.2.0.0'
#gem 'bootstrap'
gem "font-awesome-rails"

gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'twitter'
gem 'jquery-rails'
gem "rails-erd"

gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby

gem 'coffee-rails', '~> 4.2'
gem 'coffee-script-source', '1.8.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'bullet'
#gem 'sqlite3'
  gem 'mysql2'
  gem 'bullet'
  gem 'awesome_print'
  gem 'pry-rails'
  gem 'hirb'
  gem 'hirb-unicode'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'bullet'
# gem 'sqlite3'
  gem 'mysql2'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


group :production, :staging do
  gem 'mysql2'
  gem 'unicorn'
  gem 'google-analytics-rails'
  gem 'awesome_print'
  gem 'pry-rails'
  gem 'hirb'
  gem 'hirb-unicode'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
