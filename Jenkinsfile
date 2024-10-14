pipeline {
    agent {
        docker {
            image 'khuma1/jenkinsnode'
            args '-v /var/run/docker.sock:/var/run/docker.sock --privileged --user root'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                git(branch: 'main', url: 'https://github.com/sujan321-oss/ultimatecicdpipeline.git')
                sh 'echo "Cloned successfully"'
            }
        }

        stage('Building App') {
            steps {
                sh 'cd application && npm install'
                sh 'chmod +x node_modules/sonar-scanner/bin/sonar-scanner'  // Ensure sonar-scanner is executable
                sh 'echo "Build successful"'
            }
        }

        stage('Static Code Analysis') {
            environment {
                sonar_url = "http://localhost:9000"
            }
            steps {
                sh 'cd application && npm run sonar'
            }
        }

        stage("Docker Login") {
            steps {
                script {
                    sh 'docker login -u "khumapokharel2076@gmail.com" -p "P00kharelk#"'
                }
            }
        }

        stage("Build Docker Image and Push to Docker Hub") {
            steps {
                script {
                    sh 'cd ultimatepipeline/application && docker build -t khuma1/finalapp .'
                    sh 'docker push khuma1/finalapp'
                }
            }
        }
    }

    post {
        success {
            echo "Successfully built the image."
        }
        failure {
            echo 'Build failed. Please check the logs.'
        }
    }
}
