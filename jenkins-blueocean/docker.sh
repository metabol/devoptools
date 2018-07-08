docker run -dit --name jenkinsblue-con \
  --rm \
  -u root \
  -p 8083:8080 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME":/home \
  jenkinsci/blueocean
