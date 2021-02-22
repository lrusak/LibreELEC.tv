pipeline {
    agent {
      label 'images'
    }

    options {
        skipStagesAfterUnstable()
        ansiColor('xterm')
    }

    stages {

         stage('Clean') {
            steps {
                echo "Cleaning build directory"
                sh "make clean"
                sh "rm -rf target/*"
            }
        }

         stage('Sources') {
            when {
                expression { env.LIBREELEC_SOURCES != null }
            }

            steps {
                echo "Linking Sources"
                sh "ln -sf ${env.LIBREELEC_SOURCES} sources"
            }
        }

        stage('Build') {
            steps {
                echo "Building ${env.PROJECT} ${env.DEVICE} ${env.ARCH}"
                sh "make image"
            }
        }

        stage('Archive') {
            steps {
                echo "Archiving build artifacts"
                archiveArtifacts artifacts: 'target/*.tar,target/*.tar.sha256,target/*.img.gz,target/*.img.gz.sha256',
                                 onlyIfSuccessful: true
            }
        }

        stage('Publish') {
            steps {
                echo "Publishing archives..."
            }
        }
    }
}
