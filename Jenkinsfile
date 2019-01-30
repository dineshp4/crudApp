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
               /* agent {
                    dockerfile {
                        filename 'Dockerfile'
                    }
                }*/
            }
            stage ('Nexus') {
                steps {
                    nexusArtifactUploader artifacts: [[artifactId: 'crudApp', classifier: '', file: 'target/crudApp.war', type: 'war']], credentialsId: 'nexus', groupId: 'maven-Central', nexusUrl: '10.0.1.13:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-releases', version: '1.${BUILD_NUMBER}'
                }
            }
            stage ('Docker') {
                steps {
                    sh 'rm -rf crudA*war'
                    sh 'wget http://18.223.24.241:8081/repository/maven-releases/maven-Central/crudApp/1.$(BUILD_NUMBER}/crudApp-1.${BUILD_NUMBER}.war'
                    sh 'mv crudApp-1.${BUILD_NUMBER}.war crudApp.war'
                }
                agent {
                        dockerfile {
                            filename 'Dockerfile'
                        }
                }
            }
        }
}
