pipeline {
    agent any
    tools {
    jdk 'Java'
    maven 'Maven'
  }
    stages {
        stage('Build') {
            steps {
                if (isUnix()) {
                    sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
                } else {
                    bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
                }
            }
        }
        stage('Docker') {
        steps {
            input {
            message 'ready?'
            }
        }
        }            
         dockerfile {
            filename 'Dockerfile'
         }
      }
    }
