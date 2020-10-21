source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.7.1'


gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'figaro'
gem 'image_processing'
gem 'mini_magick'
gem 'active_storage_validations'
gem 'bcrypt'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'bootstrap-sass'
gem 'bootstrap-glyphicons'
gem 'rails-i18n'
gem "i18n-js"
gem 'puma', '~> 4.1'
gem 'font-awesome-sass-rails'
gem 'sass-rails', '>= 6'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'acts_as_list'
gem 'x-editable-rails'


group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end
group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'sqlite3'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rails-controller-testing'
  gem 'minitest', '>= 5.14.2'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
end

group :production do
  gem 'pg', '>= 0.17.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
