pipeline {
    agent {
        docker { image 'alpine:3.7' }
    }
    stages {
       stage('Checkout to the testing Repo') {
            steps {
               checkout scm
            }
        }
        stage('Run qualii script') {
            steps { 
                sh "pwd"
                sh "ls"
                sh "chmod +x ./qualiti-script.sh"
                sh "./qualiti-script.sh"   
            }
        }
    }
}
