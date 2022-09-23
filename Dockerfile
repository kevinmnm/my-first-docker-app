# Sets the base image from existing or from Docker Hub images.
FROM ubuntu

# Some commands for Ubuntu specific.
RUN apt update && apt upgrade -y

## https://docs.docker.com/engine/install/ubuntu/ ##

# Install Ubuntu packages.
RUN apt install -y \ 
   sudo \
   lsb-core \
   lsb-release \ 
   curl \
   nodejs \ 
   apache2 \
   npm \
   nano \
   ca-certificates \
   gnupg 

# This command must be ran before and after any apt install!
RUN sudo apt update

# Install necessary global npm packages.
RUN sudo npm install -g \ 
   pm2

# This command must be ran before and after any apt install!
RUN sudo apt update

# Uninstall existing Docker Engine.
# RUN sudo apt remove \
#    docker-ce \ 
#    docker-ce-cli \
#    containerd.io \ 
#    docker-compose-plugin

# Add Docker's official GPG key in a custom directory.
RUN sudo mkdir -p /etc/apt/keyrings
RUN sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository.
RUN sudo echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# This command must be ran before and after any apt install!
RUN sudo apt update

# Install Docker Engine.
RUN sudo apt install -y \
   docker-ce \
   docker-ce-cli \
   containerd.io \
   docker-compose-plugin

# # Get to container working directory (like cd /applications command within the container).
# WORKDIR /applications

# # Copied current directory (where Dockerfile is at) to container working directory (which is ~/applications/).
# COPY . .

# Enable Apache modules needed to configure reverse proxy server for Node.js application.
RUN sudo a2enmod proxy proxy_http rewrite headers expires

# Copy current application directory to docker container directory.
COPY . /applications/my-first-docker-app

# Set default work directory (optional?).
WORKDIR /applications/my-first-docker-app

# Default command upon running container.
# CMD ["pm2", "start", "ecosystem.config.js"]

# For Docker, PM2 command starts with "pm2-runtime" for containers to stay running (https://pm2.keymetrics.io/docs/usage/docker-pm2-nodejs/#use-pm2-inside-containers).
CMD ["pm2-runtime", "ecosystem.config.js"]

# Informs Docker that the container listens on the specified network ports at runtime.
EXPOSE 3000

# RUN npm install -g pm2 && npm run build

# CMD ["pm2 start 0"]