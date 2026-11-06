// Daily network config backup.
// Needs an agent with python3 that can reach NetBox and the devices.
// Create "Secret text" credentials with the IDs used below.
pipeline {
    agent any

    triggers {
        cron('H 2 * * *')
    }

    environment {
        NETBOX_API      = credentials('netbox-api')
        NETBOX_TOKEN    = credentials('netbox-token')
        NET_USER        = credentials('net-user')
        NET_PASSWORD    = credentials('net-password')
        BACKUP_REPO_URL = credentials('backup-repo-url')
    }

    stages {
        stage('Backup') {
            steps {
                sh 'sh ci/run-backup.sh'
            }
        }
    }
}
