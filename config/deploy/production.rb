set :bundle_without, %w{staging test}.join(" ")

set :branch, "master"

server "training.digitallearn.org",
  user: fetch(:application),
  port: 1022,
  roles: %w{web app db},
  primary: true
