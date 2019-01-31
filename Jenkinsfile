pipeline {
    agent any
    environment {
        //be sure to replace "willbla" with your own Docker Hub username
        DOCKER_IMAGE_NAME = "dineshp4/train-schedule"
    }
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
            stage ('Docker Build') {
                steps {
                    sh 'wget http://10.0.1.13:8081/repository/maven-releases/maven-Central/crudApp/1.${BUILD_NUMBER}/crudApp-1.${BUILD_NUMBER}.war -O crudApp.war'
                    script {
                        app = docker.build(DOCKER_IMAGE_NAME)
                    }
                    sh 'rm -rf crud*'
                    /*sh 'docker build -t crudapp:1.${BUILD_NUMBER} .'
                    sh 'rm -rf crud*'
                    sh 'docker run -dit -p 8081:8080 --name crudapp1.${BUILD_NUMBER} crudapp:1.${BUILD_NUMBER}'*/
                }
            }
            stage ('Docker Push Image') {
                steps{
                    script {
                        docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                            app.push("${env.BUILD_NUMBER}")
                            app.push("latest")
                        }
                    }
                }
            }
            stage ('Deploy To Production') {
                steps {
                    input 'Deploy to Production?'
                    milestone(1)
                    kubernetesDeploy(
                        kubeconfigId: 'kubeconfig',
                        configs: 'crudapp-kube.yml',
                        enableConfigSubstitution: true
                    )
                }
            }
        }
}
