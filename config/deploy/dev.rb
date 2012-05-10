set :rails_env, "development"
set :repository,  "."
set :branch, "master"
set :deployment_host, "hydrus-dev.stanford.edu"
set :bundle_without, [:test]

role :web, deployment_host
role :app, deployment_host
role :db,  deployment_host, :primary => true
