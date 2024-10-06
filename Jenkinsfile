pipeline{
    agent{
        docker{
              image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages{
        stage('checkout'){
            steps{
                git branch:'main' url:'https://github.com/sujan321-oss/ultimatecicdpipeline.git'

                sh 'echo "cloned stucessfully"'
            }
        }

        stage('buildingapp'){
            steps{
               sh 'cd ultimatepipeline/application && npm install'
               sh 'echo  "build successful"'
            }
        }

        stage('static code analysis'){
            environment{
               sonar_url="http://localhost:9000"
            }
            steps{
                sh 'cd ultimatepipeline/application &&  npm run sonar'
            }
        }

        stage("Docker Login") {
            steps {
         script {
            sh 'docker login -u "khumapokharel2076@gmail.com" -p "P00kharelk#"'
        }
         }
      }

        stage("build docker image and push to the docker hub") {
            script {
                sh 'cd ultimatepipeline/application && docker build -t khuma1/finalapp .'
                sh 'docker push khuma1/finalapp'
            }
        }
        
        post {
            success{
                echo "sucessfully image is build"

            }
            failure {
            echo 'Build failed. Please check the logs.'
        }
        }

    
    }
}