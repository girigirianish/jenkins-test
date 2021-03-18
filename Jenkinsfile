pipeline {
    agent {
        docker { 
            reuseNode false
            args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
            image 'node:7-alpine'
        }
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
