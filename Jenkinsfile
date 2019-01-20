pipeline {
    agent any
        stages {
            stage('Build') {
                tools {
                    jdk 'Java'
                    maven 'Maven'
                    }
                steps {
                    sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
                    }
                }
            stage('Docker') {
                steps {
                    dockerfile {
                        filename 'Dockerfile'
                        }
                    }
                }             
            }
    }
