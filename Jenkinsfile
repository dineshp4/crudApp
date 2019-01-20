pipeline {
    agent any
    tools {
        jdk 'Java'
        maven 'Maven'
    }
        stages {
            stage('Git') {
                steps {
                    git 'https://github.com/dineshp4/crudApp.git'
                    }
                }
            stage('Build') {
                steps {
                    sh 'mvn -Dmaven.test.failure.ignore=true clean package'
                    sh '/var/lib/jenkins/workspace/crudApp4/target/crudApp.war /var/lib/jenkins/workspace/crudApp4/.'
                    //sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
                    }
                }
            stage('Docker'){
                steps {
                    sh 'sudo pwd > /root/dinesh.txt'
                    sh '/var/lib/jenkins/workspace/crudApp4/target/crudApp.war /var/lib/jenkins/workspace/crudApp4/.'
                }
                agent {
                    dockerfile {
                        filename 'Dockerfile'
                    }
                }
            }
        }
}
