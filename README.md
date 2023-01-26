# jenkins-test
This repository is a demo of a working Jenkins server that has a job that is 
triggered on any Merge Request (Pull Request) made on this repo.  
  
The docker image that runs this Jenkins server was already built and made available 
on DockerHub, to make running this demo easier.  
  
The application code can be found in the root of this repository, and the code to run 
the Jenkins server can be found under the `jenkins-server` directory.

## Usage
You can run this Jenkins server locally. In order to run it, you need to have some prerequisite:
* Docker
* Docker socket available at /var/run/docker.sock. This was tested on a Linux machine, but 
  should work in a Windows machine using WSL2.
  
Once you have those installed, please run the following command:  
```cd jenkins-server/ && docker build -t jenkins:jcasc --build-arg DOCKER_GID=$(cat /etc/group | grep '^docker:' | cut -d ':' -f 3) . && docker run -v /var/run/docker.sock:/var/run/docker.sock:rw --name jenkins --rm -p 8080:8080 --env JENKINS_ADMIN_PASSWORD=password jenkins:jcasc```  

The credentials are:  
username: `admin`  
password: `password`    
  
After you run the above command, which builds the Jenkins server locally on your computer, and then runs it, 
you should have the Jenkins server available at `http://localhost:8080`, with a job named `configuration-as-code` 
which gets executed on every Pull Request - builds the image using the Dockerfile located in the root of this repository, 
and then runs it. 
  
The above command builds a docker image of Jenkins with a list of the required plugins, among them Jenkins Configuration 
as Code (which is what made it possible to run all of this from a single cli command), and the configuration files 
describing how the Jenkins server should be set up, what jobs to create, etc... As you can probably notice, a build
argument is being passed as `--build-arg $(cat /etc/group | grep '^docker:' | cut -d ':' -f 3)`, now that is because 
on different machines the GID of docker would be different.

## Notes
As of right now, the build is being executed on every Pull Request (as requested), although 
only by manually going to Jenkins under the job `configuration-as-code`, and clicking "Scan".  
  
This can be easily converted to be executed automatically on every Pull Request creation, but 
for that to happen, we would need to have Jenkins running somewhere that can be accessible from 
the outside world, as this happens using a webhook (and you can't webhook to a place you can't access).  
  
### Security
The files in this project are utilizing a GitHub PAT which has permissions to read the Pull Requests 
of this repository. As this is only a demo project, I find this acceptable, but on a production system 
obviously the credentials would be fetched in a different way, using some kind of Vault such as 
Azure Key Vault, Hashicorp Vault, etc...
