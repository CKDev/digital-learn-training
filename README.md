# DigitalLearn Training

## Running DigitalLearn Training Locally

### Ruby Version

3.0.7

[asdf version manager](https://github.com/asdf-vm/asdf) is recommended. Navigate to the project directory and run `asdf install`.

### Rails Version

6.0.

### System dependencies

- Docker

### Start project

`foreman start -f Procfile.dev`

## Testing

Rspec is used on this project, which can be run with: `rspec`

## Developer Norms/Standards

The purpose of this section is to layout the norms of this project. Future development should follow the standard set forth in this guide.

### Ruby

Rubocop is used on this project, which defines the Ruby styling agreed upon for this project. The rules are bendable, but a best effort should be made to stay within the rubocop checks. At the time of MVP, the Rubocop checks all passed.

### JavaScript

At this time there is no JavaScript testing or linting, as there is simply not enough JS code in the app to justify the effort. This should be reassessed over time.

## Testing

A feature test to prove the actual working feature is preferred. Edge cases aren't necessary with feature tests. From that, more granular controller and model testing to cover different code paths and edge cases is ideal.

At any time, the working state of the app should be provable by running the test suite.

## Deployements

Deployment happens automatically through CodePipeline and CodeBuild. To deploy to Staging, merge PRs into the `develop` (default) branch. Merge release PRs into `main` to deploy to Production.

## Dev Ops

The infrastructure for this app is managed with Terraform. You should use Terraform version >= 1.0.

You will need an appropriate AWS IAM role to make infrastructure changes. If granted this access, please be careful and deliberate with your changes.

The Terraform scripts expect an AWS profile named `digitallearn` with credentials for your digitallearn AWS account IAM profile.

Initialize the project's terraform state by navigating to one of the environment ops directories (ex/ `/ops/staging`) and run `terraform init`. Once the state is initialized, you can begin making infrastructure changes.

### Secrets

The current method for handling sensitive information is with `.tfvars` files. See Terraform's [Sensitive Variables Documentation](https://learn.hashicorp.com/tutorials/terraform/sensitive-variables).

You can put `ops/staging/secret.tfvars` and `ops/production/secret.tfvars` in your environment in order to work with `staging` and `production` respectively with all of the variables marked `sensitive` in `variables.tf`.

Otherwise, Terraform will prompt you to enter the secrets every time you work with the infrastructure.

### Apply infrastructure changes

1. Navigate to the ops directory corresponding to the environment you wish to update (`/ops/staging` or `/ops/production`).

2. Inspect the changes to be made (and validate the Terraform code) with `terraform plan -var-file="secret.tfvars"`.

3. If everything looks good, you can run `terraform apply -var-file="secret.tfvars"` to apply the changes.
