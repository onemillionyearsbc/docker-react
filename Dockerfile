# BUILD PHASE

# Use an existing docker image as a base
FROM node:alpine as builder

WORKDIR '/app'

# copy source files (just package.json) from local folder to container file system
# then install 
COPY ./package.json ./
RUN  npm install

# leave in for production docker file or if we 
# don't use docker-compose
COPY ./ ./
RUN npm run build

# RUN PHASE

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# bollocks