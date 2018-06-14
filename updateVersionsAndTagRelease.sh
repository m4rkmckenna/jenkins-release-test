#!/bin/bash

# SETUP
git config user.email "engineering@oroson.co.uk"
git config user.name "Oroson Engineering"

git checkout -b release/${releaseVersion}

#######################
# SET RELEASE VERSION #
#######################
npm version --no-git-tag-version ${releaseVersion}

# Commit release version & tag
git add -u
git commit -m "Release :: ${releaseVersion}"
git checkout master
git merge release/${releaseVersion}

git tag -a ${releaseVersion} -m "Release :: ${releaseVersion}"

# Set next develop version
git checkout develop
git merge master

################################
# SET NEXT DEVELOPMENT VERSION #
################################
npm version --no-git-tag-version ${nextVersion}

# Commit next development version
git add -u
git commit -m "Pre-Release Version :: ${nextVersion}"

# Checkout tag
git checkout ${releaseVersion}
