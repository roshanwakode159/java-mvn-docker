pipeline{
 agent any
 stages{   
   stage('Git repo clone'){
      steps {
          sh 'sudo rm -rf java-mvn-docker*'
          sh "git clone https://github.com/roshanwakode159/java-mvn-docker.git"
      }
   }
   stage('Mvn Package'){
      steps {
        dir("/var/lib/jenkins/workspace/Jenkins-AWS-Docker-MVN/java-mvn-docker"){
         sh "ls -la"
         sh "sudo mvn clean package"
        }
      }
   }
   stage('Build Docker Image'){
      steps {
        dir("/var/lib/jenkins/workspace/Jenkins-AWS-Docker-MVN/java-mvn-docker"){
         sh 'sudo docker rmi -f $(sudo docker images -aq)'
         sh 'sudo docker build -t helloworld/javamvn:1.0.0 .'
        }
      }
   }
   stage('Push Docker Image'){
       steps {
        withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
         sh "sudo docker login -u roshanwakode159 -p ${dockerHubPwd} docker.io"
     }
         sh 'sudo docker tag helloworld/javamvn:1.0.0 roshanwakode159/helloworld:1.0.0'
         sh 'sudo docker push roshanwakode159/helloworld:1.0.0'
       }
   }
   stage('Run Container on Dev Server'){
       steps {
        sshagent(['docker-server']) {
          sh "ssh -o StrictHostKeyChecking=no ubuntu@15.206.166.138 'sudo docker rm java-app -f'" 
          sh "ssh -o StrictHostKeyChecking=no ubuntu@15.206.166.138 'sudo docker run -p 80:8080 -d --name java-app roshanwakode159/helloworld:1.0.0'"
           }
       }
   }
 }
}
