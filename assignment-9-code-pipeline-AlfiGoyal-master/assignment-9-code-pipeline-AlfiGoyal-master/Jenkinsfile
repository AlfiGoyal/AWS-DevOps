pipeline { 
    agent { label 'linux' }
    stages { 
        stage ("Unit Tests") {
          steps {
            git url: 'https://github.com/AlfiGoyal/java-project.git'
            sh "ant -f test.xml -v"
            junit "reports/result.xml"
          }
        }
        stage ("Build") {
            steps {
                sh 'ant -f build.xml -v'
            }
        }
        stage ("Deploy") {
            steps {
                    sh 'aws s3 cp /workspace/java-pipeline/dist/rectangle-*.jar s3://jenkins-assignment9-s3bucket-ag/' 
            }
        }
        stage('Report'){
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'id-2', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh 'aws cloudformation describe-stack-resources --region us-east-1 --stack-name jenkins'
                }
            }
        }
   }
}
