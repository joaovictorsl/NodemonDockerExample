# Fetching the latest LTS version of node.
FROM node:lts-alpine3.16
# ARGs are available on this whole file,
# but not when the container is running.
ARG PORT_BUILD=3000
# Environment variables are available on the container.
ENV PORT=${PORT_BUILD}
# Setting custom NODE_PATH (more on this later).
ENV NODE_PATH=/deps/node_modules
# Exposing the port to the host.
EXPOSE ${PORT}
# Creating a directory to store dependencies (more on this later).
RUN mkdir /deps

# All the code after this next line will be executed under /app
WORKDIR /app
# Copies all of the current directory to the /app directory.
COPY ./app .
# I will install dependencies on a different directory.
RUN mv package.json /deps/package.json
# All the code after this next line will be executed under /deps
WORKDIR /deps
# Install dependencies.

# I install these dependencies on a different directory because my docker compose file
# binds my /app directory with the /app of my container and I don't have the node_modules
# directory on my host machine, therefore after npm install, when the volume is mounted,
# since I have no node_modules on my host machine, the node_modules directory is deleted.

# This approach is used on development only so I can use nodemon and restart my server
# when a file changes without having to rebuild my container or copy files inside of it.
# If I change something on my code, it will be automatically updated on the container
# so nodemon will restart my server in the container.
RUN npm install
# All the code after this next line will be executed under /app
WORKDIR /app
CMD [ "nodemon" ]
