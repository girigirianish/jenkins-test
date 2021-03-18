pipeline {
    agent any
    stages {
       stage('Checkout to the testing Repo') {
            steps {
               checkout scm
            }
        }
        stage('Run qualii script') {
            steps {
             withEnv(['PATH+EXTRA=/usr/sbin:/usr/bin:/sbin:/bin']) {  
                  sh "pwd"
                  sh "ls"
                  sh "chmod +x ./qualiti-script.sh"
                  sh "./qualiti-script.sh"
             }
            
            }
        }
    }
}
