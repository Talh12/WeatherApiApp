# ApiWeatherApp

This project is a simple Weather API application that retrieves weather data and stores it in a JSON file. The project demonstrates basic DevOps skills such as CI/CD with Jenkins, containerization with Docker, and orchestration with Docker Compose.

# Prerequisites

docker 
Jenkins

# Project Structure

* main.py: The main application script that retrieves weather data and writes it to data.json.

* data.json: The file where weather data is stored.

* Dockerfile: The Dockerfile used to build the application image.

* Jenkinsfile: The file that automate all the build process and run the container. 

# Setup Instructions

1. Clone the repository:

```
git clone https://gitlab.com/talh12/apiweatherapp.git
cd ApiWeatherApp
```

2. Setup Jenkins:

```
docker run \                                                                
-d \
-p 8080:8080 \
-p 50000:50000 \
-v /var/jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
--name my-jenkins jenkins/jenkins:lts
```

3. Install docker inside jenkins container: 

``` 
docker exec -it -u 0 my-jenkins bash
apt update 
apt install docker
```

4. Edit Jenkinsfile 

```
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building the Docker image..."
                    withCredentials([usernamePassword(credentialsId: '<your docker hub credentialsId>', passwordVariable: 'PSW', usernameVariable: 'USER')]) {
                        sh 'docker build -t <docker hub username>/weather-app:latest .'
                        sh "echo $PSW | docker login -u $USER --password-stdin"
                        sh 'docker push <dockerhub username>/weather-app:latest'
                    }
                }
            }
        }

        stage('Run docker container') {
            steps {
                script {
                    echo "Running container web-weather-app ..."
                    sh 'docker run -d -p 8081:8081 --name weather-app tal5041996/weather-app:latest'
                }
            }
        }
    }
}
```
Make sure to edit your Jenkinsfile with your dockerhub username and add your docker credentialsId (lines 9-13) to the Jenkinsfile

5. log into your jenkins container:

NOTE: On your web browser
```
localhost:8080
```

6. Create new pipeline on jenkins:

On jenkins dashboard choose new item then choose pipeline job and give it a name. 

7. Configure your pipeline 

* Scroll down to Pipeline and switch to Pipeline script from SCM.

* On SCM switch to git.

* Paste the repository url under repository 
```
git clone https://gitlab.com/talh12/apiweatherapp.git
```

* Use your git credentials. 

* NOTE: If you don't have credentials, Select add and add your credentials.

* Save the pipeline job

# Run jenkins pipeline

in your jenkins pipeline selcet build now and watch the magic happen (:

After build was succesful go to your web browser and paste 
```
localhost:8081
```
and that's it now you can check the weather :) 

# Usage 

* The application will be available at http://localhost:8081.

* Weather data will be written to data.json.

# Contributing

If you would like to contribute to this project, please fork the repository and create a pull request.




