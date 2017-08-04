set :bundle_without, %w{production test}.join(" ")

set :branch, "master"

server "dl-training.ckstage.com",
  user: fetch(:application),
  port: 1022,
  roles: %w{web app db},
  primary: true
