FROM ubuntu
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

RUN sudo apt update

# Uninstall existing Docker Engine.
# RUN sudo apt remove \
#    docker-ce \ 
#    docker-ce-cli \
#    containerd.io \ 
#    docker-compose-plugin

# Add Docker's official GPG key.
RUN sudo mkdir -p /etc/apt/keyrings
RUN sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository.
RUN sudo echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

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

COPY . /applications/my-first-docker-app

WORKDIR /applications/my-first-docker-app

CMD ["node", "src/index.js"]

EXPOSE 3000

# RUN npm install -g pm2 && npm run build

# CMD ["pm2 start 0"]