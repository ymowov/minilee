source 'https://rubygems.org'

ruby "2.2.3"
gem 'rails', '4.2.4'

group :production do
  gem "rails_12factor"
  gem "unicorn"
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
  gem 'unicorn'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem "pry-rails"

end

gem "pg"
gem "bootstrap-sass", "~> 3.2.0"
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem "simple_form"
gem 'turbolinks'
gem "activerecord-import", ">= 0.4.0"