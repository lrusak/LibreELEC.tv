pipeline {
    agent {
      label 'addons'
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
                echo "ADDON_JENKINS: ${env.ADDON_JENKINS}"
                echo "ADDON_OVERWRITE: ${env.ADDON_OVERWRITE}"
                echo "ADDONS_TO_BUILD: ${env.ADDONS_TO_BUILD}"
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
                sh "./scripts/create_addon ${env.ADDONS_TO_BUILD}"
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'target/**.zip',
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
