# DigitalLearn Training

## Running DigitalLearn Training Locally

### Ruby Version

2.7.4

[asdf version manager](https://github.com/asdf-vm/asdf) is recommended. Navigate to the project directory and run `asdf install`.

### Rails Version

5.1.2

### System dependencies

- Docker

### Install gems

`docker compose run web bundle install`

### Migrate database

`docker compose run rake db:create db:migrate`

### Start Application

`docker compose up --build`

## Testing

Rspec is used on this project, which can be run with: `rspec`

#################################

## Deployment instructions

Deployment is done via Capistrano

`cap staging deploy`
`cap production deploy`

## Sync staging server db to local

`rake db:reset`
`cap staging app:local:sync`

## Developer Norms/Standards

The purpose of this section is to layout the norms of this project. Future development should follow the standard set forth in this guide.

### Ruby

Rubocop is used on this project, which defines the Ruby styling agreed upon for this project. The rules are bendable, but a best effort should be made to stay within the rubocop checks. At the time of MVP, the Rubocop checks all passed.

### JavaScript

At this time there is no JavaScript testing or linting, as there is simply not enough JS code in the app to justify the effort. This should be reassessed over time.

## Testing

A feature test to prove the actual working feature is preferred. Edge cases aren't necessary with feature tests. From that, more granular controller and model testing to cover different code paths and edge cases is ideal.

At any time, the working state of the app should be provable by running the test suite.

## Dev Ops

The infrastructure for this app is managed with Terraform. You should use Terraform version >= 1.0.

You will need an appropriate AWS IAM role to make infrastructure changes. If granted this access, please be careful and deliberate with your changes.

### Secrets

The current method for handling sensitive information is with `.tfvars` files. See Terraform's [Sensitive Variables Documentation](https://learn.hashicorp.com/tutorials/terraform/sensitive-variables).

You can put `ops/staging/secret.tfvars` and `ops/production/secret.tfvars` in your environment in order to work with `staging` and `production` respectively with all of the variables marked `sensitive` in `variables.tf`.

Otherwise, Terraform will prompt you to enter the secrets every time you work with the infrastructure.

### Apply changes

1. Navigate to the ops directory corresponding to the environment you wish to update (`/ops/staging` or `/ops/production`).

2. Inspect the changes to be made (and validate the Terraform code) with `terraform plan -var-file="secret.tfvars"`.

3. If everything looks good, you can run `terraform apply -var-file="secret.tfvars"` to apply the changes.
