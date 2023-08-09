pipeline {
    agent any

    environment {
        SERVER_IP = '207.180.253.205';
        SSH_USER = 'root'
        SSH_PASSWORD = credentials('contabo_password')
        PROJECT_FOLDER = '/var/www/salah'
        DOCKER_IMAGE_NAME = 'salah'
        CONTAINER_NAME = 'salah_container'
    }

    stages {
        stage('Connect to Server') {
            steps {
                script {
                    def remote = [name: 'contabo_server', host: SERVER_IP, user: SSH_USER, password: SSH_PASSWORD, allowAnyHosts: true]
                    sshCommand remote: remote, command: "cd ${PROJECT_FOLDER} && git pull"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def remote = [name: 'contabo_server', host: SERVER_IP, user: SSH_USER, password: SSH_PASSWORD, allowAnyHosts: true]
                    sshCommand remote: remote, command: "cd ${PROJECT_FOLDER} && docker build -t ${DOCKER_IMAGE_NAME} ."
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    def remote = [name: 'contabo_server', host: SERVER_IP, user: SSH_USER, password: SSH_PASSWORD, allowAnyHosts: true]
                    sshCommand remote: remote, command: "docker ps -a --filter \"name=${CONTAINER_NAME}\" --format \"{{.Names}}\" | grep -q \"${CONTAINER_NAME}\" && docker stop ${CONTAINER_NAME} || true"
                    sshCommand remote: remote, command: "cd ${PROJECT_FOLDER} && docker run -d --rm -it --name ${CONTAINER_NAME} --env-file .env -v app-storage:/rails/storage --network rails_apps ${DOCKER_IMAGE_NAME}"
                }
            }
        }
    }
}
