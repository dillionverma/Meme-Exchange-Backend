source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'redis'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'aasm'
gem 'active_model_serializers'
gem 'devise'
gem 'figaro'
gem 'jwt'
gem 'kaminari'
gem 'koala'
gem 'omniauth'
gem 'rack-cors', require: 'rack/cors'
gem 'responders'

gem 'redd'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'httparty'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'capistrano-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails-erd'
  gem 'rubocop', '~> 0.53.0', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
