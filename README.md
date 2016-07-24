##  docker-jenkins
Based on dockhub official Jenkins image, with the latest docker installed in the container.
The container runs as Jenkins user and can use 'docker run' command to build images. 

## How to run

Define $HOST_PORT, JENKINS_HOME on host to be mounted and IMAGE then:

```
/usr/bin/docker run --rm --name  jenkins.service -p ${HOST_PORT}:8080 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${JENKINS_HOME}:/var/jenkins_home $IMAGE
```

