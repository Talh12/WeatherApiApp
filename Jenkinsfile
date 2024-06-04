pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building the Docker image..."
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'PSW', usernameVariable: 'USER')]) {
                        sh 'docker build -t tal5041996/weather-app:latest .'
                        sh "echo $PSW | docker login -u $USER --password-stdin"
                        sh 'docker push tal5041996/weather-app:latest'
                    }
                }
            }
        }

        stage('Run docker container') {
            steps {
                script {
                    echo "Running container web-weather-app ..."
                    sh 'docker run -d -p 8081:8081 -v /Users/tal_halias/Desktop/ApiWeatherApp/data.json:/app/data.json --name weather-app tal5041996/weather-app:latest'
                }
            }
        }
    }
}
