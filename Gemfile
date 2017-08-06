source 'https://rubygems.org'

ruby '2.2.2'

if RUBY_VERSION =~ /2.2/ # default encoding for db:seed
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'rails', '~> 4.2.4'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'haml'
gem 'rake'
gem 'jasmine'
gem 'devise', '~> 3.2'
gem 'figaro'
gem "font-awesome-rails"
gem 'geocoder'
# gem "activeadmin", :git => "git://github.com/gregbell/active_admin.git"
gem 'activeadmin', "1.0.0.pre1"
gem 'test-unit', '~> 3.0'
# forum
gem 'thredded'
gem 'city-state'
gem 'capybara-email'

#Iter 2-2 Implementing image upload features (By Gung Hiu Ho, Licong Wang)
gem "paperclip", "~> 5.0.0"

#Iter 2-2 Improve form layout in activeadmin (By Gung Hiu Ho, Licong Wang)
gem 'formtastic', '~> 3.0'

#Iter 2-2 Improve Security (By Gung Hiu Ho, Licong Wang)
gem 'permitted_params'

#Iter 2-2 Improve Activeadmin UI (By Gung Hiu Ho, Licong Wang)
gem 'activeadmin_addons'

#Iter 2-2 Improve searchability for filter (By Gung Hiu Ho, Licong Wang)
gem 'ransack'
#End of iter 2-2

gem 'protected_attributes'

gem 'rich', github: 'jpros/rich', :branch => 'icons'

#Iter 4-2 Growth management 
gem 'cohort_me'
gem 'groupdate'
gem "chartkick"
gem 'impressionist'
gem "activerecord-tableless", "~> 1.0"

#Iter 4-2 activeadmin layout
gem 'active_admin_theme'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', '5.0.0'
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
  gem 'rspec-rails', '~> 2.14.0'
  gem 'simplecov'
  gem 'factory_girl'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'codeclimate-test-reporter'
	gem 'reek'
	gem 'poltergeist'
	gem 'phantomjs', :require => 'phantomjs/poltergeist'
	gem 'rack_session_access'
end

group :production do
  gem 'pg'
end

group :assets do
  gem 'uglifier'
  gem 'therubyracer'
  gem 'sass-rails'
  gem 'coffee-rails'
end

gem 'omniauth-facebook', :github => 'mkdynamic/omniauth-facebook'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
