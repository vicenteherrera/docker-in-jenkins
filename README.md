# Running Docker in Jenkins (in Docker)

_Is running Docker in Docker secure?_ **NO**

Based on https://blog.container-solutions.com/running-docker-in-jenkins-in-docker  
Read also: 
* https://devopscube.com/run-docker-in-docker/  
* https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/

```bash
docker build -t myjenk .

docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
       -p 8080:8080 --name myjenk myjenk
```

* Open the Jenkins home page in a browser http://127.0.01:8080
* When the browser prompts you for the administrator password, execute this on the terminal to get it:
  `docker exec -it myjenk cat /var/jenkins_home/secrets/initialAdminPassword`
* Install suggested plugins if you want (slower), but you don't need them for this example.
* Create first admin user, confirm local URL.
* Click the "create new jobs" link.
* Enter the item name (e.g. "docker-test"), select "Freestyle project" and click OK.
* On the configuration page, click "Add build step" then "Execute shell".
* In the command box enter `sudo docker run hello-world`
* Click "Save".
* Click "Build Now".
* Under "Build History", a new "#1" item will appear, click on it.
* Click "Console Output"

The Dockerfile still needs to install some additional libraries.

```Console
Started by user admin
Running as SYSTEM
Building in workspace /var/jenkins_home/workspace/Test
[Test] $ /bin/sh -xe /tmp/jenkins12039084177292341636.sh
+ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pulling fs layer
2db29710123e: Verifying Checksum
2db29710123e: Download complete
2db29710123e: Pull complete
Digest: sha256:cc15c5b292d8525effc0f89cb299f1804f3a725c8d05e158653a563f15e4f685
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

Finished: SUCCESS
```

