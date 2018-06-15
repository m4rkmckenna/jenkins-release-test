#!/usr/bin/env groovy

node {

  stage('Setup') {
    checkout([
            $class                           : 'GitSCM',
            branches                         : [[name: '*/develop']],
            doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
            extensions                       : [[$class: 'WipeWorkspace']],
            userRemoteConfigs                : [
                    [
                            credentialsId: 'm4rkmckenna-ssh',
                            url          : 'git@github.com:m4rkmckenna/jenkins-release-test.git'
                    ]
            ]
    ])
    sh('npm ci')
  }

  stage('Validate') {
    env.currentVersion = sh(returnStdout: true, script: 'cat package.json | jq -r ".version"').trim()
    if (env.releaseVersion) {
      assert env.releaseVersion ==~ /^\d+.\d+.\d+$/: 'releaseVersion not formatted correctly'
      if (sh(returnStatus: true, script: "semver ${env.releaseVersion} -r '>${env.currentVersion}'") != 0) {
        error("Validation Failed :: ${env.releaseVersion} must be greater then the current version ${env.currentVersion}")
      }
    } else {
      env.releaseVersion = sh(returnStdout: true, script: "semver ${env.currentVersion} --increment minor").trim()
    }
    env.nextVersion = sh(returnStdout: true, script: "semver ${env.releaseVersion} --increment preminor --preid devlop").trim()
    println("\n\tCurrent Version\t:: [${env.currentVersion}]\n\tRelease Version\t:: [${env.releaseVersion}]\n\tNext Version\t:: [${env.nextVersion}]\n")
  }

  stage('Update Versions & Tag') {
    sh('./updateVersionsAndTagRelease.sh')
  }

  stage('Build & Package Release') {
    println('PLACEHOLDER :: build & package release')
  }

  stage('Deploy Release') {
    println('PLACEHOLDER :: deploy release')
  }

  stage('Tag Release') {
    sshagent(['m4rkmckenna-ssh']) {
      sh("git push origin develop master ${env.releaseVersion}")
    }
  }

}