stage  ('test') {
    node ('docker-jenkins-slave'){
        git "${GITHUBREPO}"
        sh 'chmod a+x ./run_test.sh'
        sh './run_test.sh'
    }
    node(){
       git "${GITHUBREPO}"
       stage('build the image'){
           withDockerServer([credentialsId: 'staging-server',uri:"${DOCKERHOST}"]){
               docker.build "${DOCKERUSER}/rsvpapp:mooc"
           }
       }
       stage ('push the image to docker hub'){
           withDockerServer([credentialsId: 'staging-server',uri:"${STAGING}"]){
               withDockerRegistry([credentialsId: 'DockerHub']){
                   docker.image("${DOCKERUSER}/rsvpapp:mooc").push()
               }
           }
       }
       stage ('deploy image to staging server'){
           withDockerServer([credentialsId: 'staging-server',uri:"${STAGING}"]){
                sh 'docker-compose pull'
                sh 'docker-compose -p rsvp_staging up -d'
           }
           input("Check application running at ${STAGINGAPP} looks good?")
            withDockerServer([credentialsId: 'staging-server',uri:"${STAGING}"]){
                sh 'docker-compose -p rsvp_staging down -v'
           }
       }
       stage ('deploy in production ') {
           withDockerServer([credentialsId: 'production',uri:"${PRODUCTION}"]){
               sh 'docker stack deploy -c docker-stack.yml myrsvpapp'
               input("check application running at ${PRODUCTIONAPP}?")
           }
           withDockerServer([credentialsId: 'production',uri:"${PRODUCTION}"]){
               sh 'docker stack down myrsvpapp'
           }
       }
    }
}
