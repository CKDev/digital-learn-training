set :bundle_without, %w{production test}.join(" ")

set :branch, "main"

server "dl-training.ckstage.com",
  user: fetch(:application),
  port: 1022,
  roles: %w{web app db},
  primary: true
