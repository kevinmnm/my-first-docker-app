## Creating Docker Container (should be one time thing as container will be pushed/pulled after creation)

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