pipeline {
    agent any
    stages {
        stage('Run qualii script') {
            steps {
               sh "chmod +x ./qualiti-script.sh &&  ./qualiti-script.sh"
            }
        }
    }
}
