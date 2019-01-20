pipeline {
    agent any
        stages {
            stage('Git') {
                steps {
                    git 'https://github.com/dineshp4/crudApp.git'
                    }
                }
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
