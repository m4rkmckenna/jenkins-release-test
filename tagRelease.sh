#!/usr/bin/env bash

git config user.email "engineering@oroson.co.uk"
git config user.name "Oroson Engineering"
git checkout -b release/${releaseVersion}
git add -u
git commit -m "Release :: ${releaseVersion}"
git checkout master
git merge release/${releaseVersion}
git tag -a ${releaseVersion} -m "Release :: ${releaseVersion}"
git checkout develop
git merge master
echo "${releaseVersion}_1" > version.txt
git add -u
git commit -m "Setting Pre-Relese Version :: ${releaseVersion}_1"
git push origin develop master ${releaseVersion}
