pipeline {
    agent any
    environment {
        DOCKER_HUB_REPO = "thibaultdp/jenkins-docker-image"
        CONTAINER_NAME = "jenkins-docker"
        STUB_VALUE = "200"
    }
    stages {
        stage('Stubs-Replacement'){
            steps {
                // 'STUB_VALUE' Environment Variable declared in Jenkins Configuration 
                echo "STUB_VALUE = ${STUB_VALUE}"
                sh "sed -i 's/<STUB_VALUE>/$STUB_VALUE/g' config.py"
                sh 'cat config.py'
            }
        }
        stage('Build') {
            steps {
                //  Building new image
                sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
                sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'
                
                sh 'docker login -u thibaultdp -p dckr_pat_fqPqbnu_pKlpRR0iLOy8PVh7aW4'
                //  Pushing Image to Repository
                sh 'docker push thibaultdp/jenkins-docker-image:$BUILD_NUMBER'
                sh 'docker push thibaultdp/jenkins-docker-image:latest'
                
                echo "Image built and pushed to repository"
            }
        }
        stage('Deploy') {
            steps {
                script{
                    //sh 'BUILD_NUMBER = ${BUILD_NUMBER}'
                    
                    sh 'docker run --name $CONTAINER_NAME -d -p 5000:5000 $DOCKER_HUB_REPO'
                
                    sh 'docker stop $CONTAINER_NAME'
                    sh 'docker rm $CONTAINER_NAME'
                    sh 'docker run --name $CONTAINER_NAME -d -p 5000:5000 $DOCKER_HUB_REPO'
                    
                    //sh 'echo "Latest image/code deployed"'
                }
            }
        }
    }
}