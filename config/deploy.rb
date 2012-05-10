require "rvm/capistrano"                               # Load RVM's capistrano plugin.
require 'bundler/setup'
require 'bundler/capistrano'
#require 'dlss/capistrano'

set :stages, %W(dev testing prod demo)
set :default_stage, "dev"
set :bundle_flags, "--quiet"
set :rvm_ruby_string, "1.9.3"
set :rvm_type, :system

require 'capistrano/ext/multistage'

before "deploy:setup", "hydrus:create_gemset"
after "deploy:create_symlink", "hydrus:trust_rvmrc"
#after "deploy:restart", "dlss:log_release"

# FIXME: we need to put the certs and so on outside the app so they are not dependent on app release ... but this is not the way
#set :shared_children, %w(log config/certs config/environments config/database.yml config/solr.yml)

# FIXME: user should be alias account, once account is set up
set :user, "ndushay" 
# FIXME: ended up setting up an ssh key on hydrus box 
set :ssh_options, {:auth_methods => %w(gssapi-with-mic publickey hostbased), :forward_agent => true}

# FIXME: move to deployment dir after alias account is set up
set :destination, "/home/ndushay"
set :application, "hydrus"

set :scm, :git
set :deploy_via, :copy # I got 99 problems, but AFS ain't one
set :copy_cache, true
set :copy_exclude, [".git"]
set :use_sudo, false
set :keep_releases, 10

set :deploy_to, "#{destination}/#{application}"

namespace :hydrus do
  task :trust_rvmrc do
    run "/usr/local/rvm/bin/rvm rvmrc trust #{latest_release}"
  end
  task :create_gemset do
#    run "/usr/local/rvm/bin/rvm use 1.9.3@hydrus --create"
    run "rvm use 1.9.3@hydrus --create"
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end