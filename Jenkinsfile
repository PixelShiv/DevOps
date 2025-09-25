pipeline {
    agent { label 'linuxgit' } // change to 'any' if you do not have that label

    environment {
        GIT_REPO  = 'https://github.com/PixelShiv/DevOps.git'
        BRANCH    = 'master'
        RECIPIENT = 'kumarpshivap@gmail.com'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                echo 'Cleaning workspace'
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                echo "Cloning ${GIT_REPO} branch ${BRANCH}"
                git branch: "${BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                sh 'dos2unix build.sh || true'
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }
    }

    post {
        success {
            emailext(
                subject: "Build Success: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: "<p>Build succeeded in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>",
                to: "${RECIPIENT}"
            )
        }
        unstable {
            emailext(
                subject: "Build Unstable: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: "<p>Build is <b>UNSTABLE</b> in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>",
                to: "${RECIPIENT}"
            )
        }
        failure {
            emailext(
                subject: "Build Failed: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: "<p>Build <b>FAILED</b> in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>",
                to: "${RECIPIENT}"
            )
        }
    }
}
