docker run -dit --name jenkins-blue-con \
  -p 8083:8080 \
  -v jenkins-data:/var/jenkins_home \
  jenkinsci/blueocean
