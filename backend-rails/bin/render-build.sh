#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails db:create RAILS_ENV=production
bundle exec rails db:migrate RAILS_ENV=production
bundle exec rails db:seed RAILS_ENV=production