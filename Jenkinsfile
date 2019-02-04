pipeline {
    agent any
    environment {
        NEXUS_IP= "10.0.1.8"
        DOCKER_IMAGE_NAME = "dineshp4/crudapp"
        CANARY_REPLICAS = 0
    }
    tools {
     //   jdk 'Java'
        maven 'maven2'
    }
        stages {
           /* stage ('Git') {
                steps {
                    git 'https://github.com/dineshp4/crudApp'
                }
            } */
            stage('Build') {
                steps {
                    sh 'mvn -Dmaven.test.failure.ignore=true clean package'
                    //sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
                    }
            }
            stage ('Nexus') {
                steps {
                    nexusArtifactUploader artifacts: [[artifactId: 'crudApp', classifier: '', file: 'target/crudApp.war', type: 'war']], credentialsId: 'nexus', groupId: 'maven-Central', nexusUrl: '10.0.1.8:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-releases', version: '1.${BUILD_NUMBER}'
                }
            }
            stage ('Docker Build') {
                steps {
                    sh 'wget http://10.0.1.8:8081/repository/maven-releases/maven-Central/crudApp/1.${BUILD_NUMBER}/crudApp-1.${BUILD_NUMBER}.war -O crudApp.war'
                    script {
                        app = docker.build(DOCKER_IMAGE_NAME)
                    }
                    sh 'rm -rf crud*'
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
            stage('CanaryDeploy') {
               /* when {
                    branch 'master'
                } */
                environment {
                    CANARY_REPLICAS = 1
                }
                steps {
                    kubernetesDeploy(
                        kubeconfigId: 'kubeconfig',
                        configs: 'canary-kube.yml',
                        enableConfigSubstitution: true
                    )
                }
            }
            stage('SmokeTest') {
               /* when {
                    branch 'master'
                } */
                steps {
                    script {
                        sleep (time: 5)
                        def response = httpRequest (
                            url: "http://$KUBE_MASTER_IP:8081/",
                            timeout: 30
                        )
                        if (response.status != 200) {
                            error("Smoke test against canary deployment failed.")
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
                        configs: 'kube',
                        enableConfigSubstitution: true
                    )
                }
            }
        }
}
