source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem "bcrypt", "~> 3.1.7"
gem "carrierwave", "1.1.0"
gem "bootstrap-sass", "3.3.6"
gem "bootstrap-will_paginate", "1.0.0"
gem "coffee-rails", "~> 4.2"
gem "config", "1.2.1"
gem "faker", "1.7.3"
gem "fog", "1.40.0"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "mini_magick", "4.7.0"
gem "puma", "~> 3.0"
gem "rails", "~> 5.0.4"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "will_paginate", "3.1.5"

group :development, :test do
  gem "byebug", platform: :mri
  gem "sqlite3"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg", "0.18.4"
  gem "rails_12factor"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
