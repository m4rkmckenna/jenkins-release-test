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
      sh "echo ${releaseVersion} > version.txt"
    }
    stage('Tag & Push') {
      sshagent(['m4rkmckenna-ssh']) {
        sh("""
        git config user.email "engineering@oroson.co.uk"
        git config user.name "Oroson Engineering"
        git add -u
        git commit -m \"Release :: ${releaseVersion}\"
        git tag -a ${releaseVersion} -m \"Release :: ${releaseVersion}\"
        git push origin ${releaseVersion}
        """)
      }
    }
  }
}