set :rails_env, "test"
set :deployment_host, "hydrus-test.stanford.edu"
set :repository,  "."
set :branch, "master"
set :bundle_without, [:deployment,:development,:test]

role :web, deployment_host
role :app, deployment_host
role :db,  deployment_host, :primary => true
