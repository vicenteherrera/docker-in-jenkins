# Running Docker in Jenkins (in Docker)

_Is running Docker in Docker secure?_ **NO**

**This example still doesn't work**

Based on https://blog.container-solutions.com/running-docker-in-jenkins-in-docker  
Read also: https://devopscube.com/run-docker-in-docker/  

```bash
docker build -t myjenk .

docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
       -v $(which docker):/usr/bin/docker -p 8080:8080 \
       --name myjenk myjenk
```

* Open the Jenkins home page in a browser http://127.0.01:8080 
* When the browser prompts you for the administrator password, execute this on the terminal to get it:
  `docker exec -it myjenk cat /var/jenkins_home/secrets/initialAdminPassword`
* Install suggested plugins
* Create first admin user, confirm local URL
* Click the "create new jobs" link.
* Enter the item name (e.g. "docker-test"), select "Freestyle project" and click OK.
* On the configuration page, click "Add build step" then "Execute shell".
* In the command box enter `docker run hello-world`
* Click "Save".
* Click "Build Now".
* Under "Build History", a new "#1" item will appear, click on it.
* Click "Console Output"

The Dockerfile still needs to install some additional libraries.

```Console
Started by user admin
Running as SYSTEM
Building in workspace /var/jenkins_home/workspace/test
[test] $ /bin/sh -xe /tmp/jenkins3579694298106748635.sh
+ docker run hello-world
docker: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by docker)
docker: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by docker)
Build step 'Execute shell' marked build as failure
Finished: FAILURE
```

