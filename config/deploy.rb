require "rvm/capistrano"
require 'bundler/capistrano'

set :rvm_bin_path, "/usr/local/rvm/bin"
set :bundle_flags,               "--deployment"
set :application,                "churumelas"
set :hostname,                   "churumelas.ideia.me"
set :deploy_to,                  "/var/www/apps/churumelas"
set :rvm_type, :system
set :rails_env,                  "production"
set :user,                       "root"
set :scm,        :git
set :repository, "git@github.com:jonatas/#{application}.git"
set :branch,     "master"

role :app, hostname
role :db,  hostname, :primary => true

namespace :deploy do
  desc "Stopping mizuno" do
    run "cd #{current_path} && mizuno --stop"
  end
  desc "Starting mizuno"
  task :start  do
    run "cd #{current_path} && bundle exec mizuno --port 80 -E production -D --start"
  end
  #after 'deploy:update_code' do
      #run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
  #end
end
