#!/usr/bin/env groovy

node {
  stage('Validate') {
    assert env['releaseVersion'] ==~ /^\d+.\d+.\d+$/: 'releaseVersion not formatted correctly'
  }
  stage('Tag Release') {
    stage('Checkout') {
      checkout([
              $class                           : 'GitSCM',
              branches                         : [[name: '*/develop']],
              doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
              extensions                       : scm.extensions,
              userRemoteConfigs                : [
                      [
                              credentialsId: 'm4rkmckenna-ssh',
                              url          : 'git@github.com:m4rkmckenna/jenkins-release-test.git'
                      ]
              ]
      ])
    }
    stage('Update Versions') {
      sh 'env | sort'
    }
  }
}