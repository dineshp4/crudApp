pipeline {
    agent any
    tools {
    jdk 'Java'
  }
    stages {
        stage('Git') {
            git 'https://github.com/dineshp4/crudApp.git'
            mvnHome = tool 'Maven'
        }
        
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
        input {
            message 'ready?'
            }
        }
         dockerfile {
            filename 'Dockerfile'
         }
      }
    }
