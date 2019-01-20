pipeline {
    agent any
    tools {
        jdk 'Java'
        maven 'Maven'
    }
        stages {
            
            stage('Build') {
                steps {
                    sh 'mvn -Dmaven.test.failure.ignore=true clean package'
                    //sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
                    }
                agent {
                    dockerfile {
                        filename 'Dockerfile'
                    }
                }
            }
        }
}
