## Creating Dockerfile

```dockerfile
# Base image.
FROM ubuntu

RUN sudo apt update && sudo apt upgrade -y

## https://docs.docker.com/engine/install/ubuntu/ ##

# Install Ubuntu packages.
RUN sudo apt install -y \ 
   lsb-core \
   curl \
   nodejs \ 
   npm \
   nano \
   ca-certificates \
   gnupg \
   proxy \
   proxy_http \
   rewrite \ 
   headers \ 
   expires

# Add Docker's official GPG key.
RUN sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Install Docker Engine.
RUN sudo apt install -y \
   docker-ce \ 
   docker-ce-cli \
   containerd.io \ 
   docker-compose-plugin
```

## Useful Ubuntu (linux) commands:


#### Check if package is installed or not:
- `sudo apt-cache policy <package name>`

`sudo apt-cache policy nano`

---

#### Create docker container with custom name:
- `docker container create --name <custom name> <image name>`

`docker create --name my_container ubuntu`

---

#### Rename docker container
- `docker rename <current name or uuid> <new name>`

`docker rename my_container my_container_1`

---

#### Build docker image with Dockerfile
***This will build new image named `<custom image name>` using `Dockerfile` located in `<Dockerfile directory>`.***

- `docker build -t <custom image name> <Dockerfile directory>`

`docker build -t my_docker_image .`


---

#### Run docker container after build
> ***This will run new container from `<built image name>` and create a mapping between the port `<host port>` to the port `<container port>`. Created container name will be random.***

- `docker run -dp <host port>:<container port> <built image name>`

`docker run -dp 3000:3000 my_image`


---

#### Run docker container after build with custom container name
> ***This will run new container form `<built image name>` and create a mapping between the port `<host port>` to the port `<container port>`. Created container will have name `<custom container name>`.***

- `docker run --name <custom container name> -dp <host port>:<container port> <built image name>`

`docker run --name my_container -dp 3000:3000 my_image`


---

#### Get to Docker container CLI:
- `docker exec -it <container name or hash> <shell or bash location>`

`docker exec -it my_container sh`

`docker exec -it my_container bash`

`docker exec -it my_container /bin/sh`

---

#### Check Ubuntu version
- `sudo apt install lsb-release`

`lsb_release -a`
