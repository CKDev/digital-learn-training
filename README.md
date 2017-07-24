# Greenfield (V3) Starter Project

The purpose of this project is to speed up initializing a new Rails
project.  Our agreed upon list of Rails gems and settings are included so
that we don't need to discuss each choice that has been made in the past.

## Starting a new project using this template

* Clone this project from Github
  - git clone git@github.com:CKDev/greenfield-v3.git
* Create a new gemset with 'rvm gemset create <project name>'
* Change .ruby-gemset for new project name
* Run `bundle install`
* Copy secrets.yml.example to secrets.yml.
* Create a new secret_key_base, one for development and one for test with `rake secret` and put in the secrets.yml file.
* Find and replace all instances of "greenfield" throughout the app
* Update the git remotes
  * `git remote -v` (should still point to greenfield)
  * `git remote rm origin`
  * `git remote add origin git@github.com:<new repo>`
* Create configure the database
  * Run `rake db:create db:migrate db:seed`
* Configure Redis - TODO:
* Configure Sidekiq - TODO:

## Replace this README with application specific information below.

# Greenfield

## Running Greenfield Locally

### Ruby Version

2.4.1

### Rails Version

5.1.2

### System dependencies

* Redis
* Postgresql

## Testing

Rspec is used on this project, which can be run with: `rspec`

## Services

* Sidekiq

## Deployment instructions

Deployment is done via Capistrano

`cap staging deploy`
`cap production deploy`

Note that sidekiq is required for this app to be functional, and therefore after deployment should be checked.

On the server run `ps aux | grep sidekiq` and verify that the service is running.

## Developer Norms/Standards

The purpose of this section is to layout the norms of this project.  Future development should follow the standard set forth in this guide.

### Ruby

Rubocop is used on this project, which defines the Ruby styling agreed upon for this project.  The rules are bendable, but a best effort should be made to stay within the rubocop checks.  At the time of MVP, the Rubocop checks all passed.

### JavaScript

[Info on JavaScript testing/code standars and norms]

(E.g. from the Showami Project, replace with this project's norms)

At this time there is no JavaScript testing or linting, as there is simply not enough JS code in the app to justify the effort. This should be reassessed over time.

## Testing

[Info on Rails testing/code standars and norms]

(E.g. from the Showami Project, replace with this project's norms)

This project was test driven from the start, and any new features or bug fixes must have an accompanying test, or a valid reason as to why a test isn't possible. At the time of the MVP the testing coverage was > 98%.

A feature test to prove the actual working feature is preferred.  Edge cases aren't necessary with feature tests.  From that, more granular controller and model testing to cover different code paths and edge cases is ideal.

At any time, the working state of the app should be provable by running the test suite.

## Server Environments

[Info on deployment norms]

(E.g. from the Showami Project, replace with this project's norms)

I am following a simple branching strategy.  Master at this time is the main branch, and is deployed to staging for review.  Developers should use feature branches for development, but then merge to master for review. The Production server environment maps to the production github branch.

I'm following a tagged release strategy, loosely based on SemVer.  Master should be tagged, using SemVer, and then the cuts of the production branch can be made a specific tag points, with the release notes being the oneline commit titles from the previous tag.

For example:

* First get release notes (in a different tab)
`git log --oneline`
`git tag -a vx.x.x` (Add title for release, then paste in release notes from above step)
`git push origin vx.x.x`

## Git Commits

Git commits are like any other piece of code, and should be done with intention.  There are two parts to the commit - the
title and the body.  The title in Github is limited to 50 characters, so the first line of a commit should also be limited to 50 characters.  The body is limited to 72 characters in width, make sure your lines are no longer than 72 characters.

More importantly, a title should have a tag like [CHG], [FEAT], [REFAC], [BUG] etc, so that when a release is made, the corresponding changes are all easily visible.  The body of a commit should list the why, not the how.  The how should be obvious by the corresponding code changes.  The title should be in the active voice, i.e. "Change timeout to two hours", not "Changes timeout to two hours."  An easy way to remember this is that the commit title should finish the sentence, "If I pull in this change it will ..."

Commits should be "squashed" into atomic chunks of code, usually corresponding with a full feature or change.  WIP commits are not within the code standards of this project.  Any checkin should be deployable, without having to consider the surrounding commits.

## Other things to know, tricky areas of this application

...
