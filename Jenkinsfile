pipeline {
    agent any
    environment {
        GIT_REPO = 'https://github.com/PixelShiv/DevOps.git'
        BRANCH = 'master'
    }
    stages {
        stage('Prepare Tools') {
            steps {
                echo 'Installing required tools...'
                sh '''
                    # Update and install Python3/pip3 if missing
                    if ! command -v pip3 &>/dev/null; then
                        sudo yum install -y python3 python3-pip || true
                    fi
                    # Install cmakelint
                    pip3 install --quiet cmakelint
                    # Install dos2unix
                    if ! command -v dos2unix &>/dev/null; then
                        sudo yum install -y dos2unix || true
                    fi
                    # Install cmake
                    if ! command -v cmake &>/dev/null; then
                        sudo yum install -y epel-release || true
                        sudo yum install -y cma
