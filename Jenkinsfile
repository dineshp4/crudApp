pipeline {
    agent any
    stages {
        stage('Git') {
            git 'https://github.com/dineshp4/crudApp.git'
            mvnHome = tool 'Maven'
        }
        stage('Java') {
            steps {
                env.JAVA_HOME="${tool 'Java'}"
                env.PATH="${env.JAVA_HOME}/bin:${env.PATH}"
                sh 'java -version'
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
