#!/usr/bin/env groovy

node {
  stage('Validate') {
      println "SHOULD VALIDATE"
  }
  stage('Checkout') {
      checkout([
            $class                           : 'GitSCM',
            branches                         : [[name: '*/master']],
            doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
            extensions                       : scm.extensions,
            userRemoteConfigs                : scm.userRemoteConfigs
    ])
  }
  stage('Update Versions') {
      println 'update version'
  }

  stage('Tag Release') {
    println 'tag release'
  }
}