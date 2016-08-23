require 'bundler/capistrano'
load 'deploy/assets'
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :system

default_run_options[:pty] = true  # Must be set for the password prompt

set :user, "ubuntu"
set :deploy_to, '/srv/prairiefire'
                                  # from git to work
set :application, "prairiefire"
set :repository,  "git@github.com:ditech/prairiefire.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :app_symlinks, %w{uploads videos}

host =  "54.221.219.32" # "64.126.117.102" #
role :web, host                          # Your HTTP server, Apache/etc
role :app, host                          # This may be the same as your `Web` server
role :db,  host, :primary => true # This is where Rails migrations will run
set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :create_dirs do
    if app_symlinks
      app_symlinks.each do |link|
        run "mkdir -p #{shared_path}/system/#{link}"
        run "ln -nfs #{shared_path}/system/#{link} #{release_path}/public/#{link}"
      end
    end
  end
end

after "deploy:finalize_update", "deploy:create_dirs"
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
