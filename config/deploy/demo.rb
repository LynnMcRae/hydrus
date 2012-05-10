set :rails_env, "production"
set :repository,  "git://github.com/sul-dlss/hydrus.git"
set :branch, "master"
set :deployment_host, "hydrus-demo.stanford.edu"
set :bundle_without, [:deployment,:development,:test]

role :web, deployment_host
role :app, deployment_host
role :db,  deployment_host, :primary => true
