pipeline {
    agent {
      label 'images'
    }

    options {
        skipStagesAfterUnstable()
        ansiColor('xterm')
    }

    stages {
         stage('Environment Variables') {
            steps {
                echo "Reading environment variables"
                echo "PROJECT: ${env.PROJECT}"
                echo "DEVICE: ${env.DEVICE}"
                echo "ARCH: ${env.ARCH}"
                echo "BUILD_DIR: ${env.BUILD_DIR}"
                echo "SOURCES_DIR: ${env.SOURCES_DIR}"
                echo "TARGET_DIR: ${env.TARGET_DIR}"
                echo "CONCURRENCY_MAKE_LEVEL: ${env.CONCURRENCY_MAKE_LEVEL}"
                echo "BUILD_PERIODIC: ${env.BUILD_PERIODIC}"
            }
        }

         stage('Clean') {
            steps {
                sh "make clean"
                sh "rm -rf target/*"
            }
        }

        stage('Build') {
            steps {
                sh "make image"
            }
        }

        stage('Archive') {
            steps {
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
