pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/PixelShiv/DevOps.git'
        BRANCH = 'master'

        // SonarQube Configuration
        SONARQUBE_ENV = 'sonarQube'
        SONAR_PROJECT_KEY = 'cmake-tocken'
        SONAR_PROJECT_NAME = 'cmake-tocken'
        SONAR_HOST_URL = 'http://ec2-34-228-65-188.compute-1.amazonaws.com:9000'
    }

    stages {
        stage('Prepare Tools') {
            steps {
                echo 'Installing required tools...'
                sh '''
                    # Install Python and pip if missing
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
                        sudo yum install -y cmake || true
                    fi

                    # Install gcc/g++
                    if ! command -v gcc &>/dev/null; then
                        sudo yum install -y gcc gcc-c++ || true
                    fi
                '''
            }
        }

        stage('Lint') {
            steps {
                echo 'Running lint checks on main.c...'
                sh '''
                    if [ -f src/main.c ]; then
                        cmakelint src/main.c > lint_report.txt
                    else
                        echo "main.c not found!"
                        exit 1
                    fi
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: 'lint_report.txt', fingerprint: true
                    fingerprint 'src/main.c'
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Running build.sh...'
                sh '''
                    if [ -f build.sh ]; then
                        dos2unix build.sh
                        chmod +x build.sh
                        bash build.sh
                    else
                        echo "build.sh not found!"
                        exit 1
                    fi
                '''
            }
        }

        stage('Unit Tests (Placeholder)') {
            steps {
                echo 'Skipping unit tests for now...'
                echo 'Once flow succeeds, this stage can run ctest or similar commands.'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube analysis...'
                withSonarQubeEnv("${sonarQube}") {
                    sh '''
                        sonar-scanner \
                          -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                          -Dsonar.projectName=${SONAR_PROJECT_NAME} \
                          -Dsonar.sources=src \
                          -Dsonar.host.url=${SONAR_HOST_URL} \
                          -Dsonar.login=${key-sonar} \
                          -Dsonar.sourceEncoding=UTF-8
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Build, lint, and SonarQube analysis completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs or SonarQube dashboard.'
        }
    }
}
