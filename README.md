# DigitalLearn Training

## Running DigitalLearn Training Locally

### Ruby Version

2.4.1

### Rails Version

5.1.2

### System dependencies

* Postgresql

## Testing

Rspec is used on this project, which can be run with: `rspec`

## Deployment instructions

Deployment is done via Capistrano

`cap staging deploy`
`cap production deploy`

## Sync staging server db to local
`rake db:reset`
`cap staging app:local:sync`

## Developer Norms/Standards

The purpose of this section is to layout the norms of this project.  Future development should follow the standard set forth in this guide.

### Ruby

Rubocop is used on this project, which defines the Ruby styling agreed upon for this project.  The rules are bendable, but a best effort should be made to stay within the rubocop checks.  At the time of MVP, the Rubocop checks all passed.

### JavaScript

At this time there is no JavaScript testing or linting, as there is simply not enough JS code in the app to justify the effort. This should be reassessed over time.

## Testing

A feature test to prove the actual working feature is preferred.  Edge cases aren't necessary with feature tests.  From that, more granular controller and model testing to cover different code paths and edge cases is ideal.

At any time, the working state of the app should be provable by running the test suite.

## Server Environments

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

We changed the language a little bit and now have Trainings and Courses.  However, in the app the models are Courses (Trainings) and CourseMaterials (Courses).  At some point it would be nice to fix this, but it's a bit of work for sure.

...

TODO: We don't have a strikethrough font, remove from ckeditor.
