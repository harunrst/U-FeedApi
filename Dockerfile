# Use NodeJS base image
FROM node:13

ENV POSTGRES_USERNAME=$POSTGRES_USERNAME
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ENV POSTGRES_HOST=$POSTGRES_HOST
ENV POSTGRES_DB=$POSTGRES_DB
ENV AWS_BUCKET=$AWS_BUCKET
ENV AWS_REGION=$AWS_REGION
ENV AWS_PROFILE=$AWS_PROFILE
ENV JWT_SECRET=$JWT_SECRET
ENV URL=$URL

RUN echo $POSTGRES_HOST

# Create app directory
WORKDIR /usr/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source
COPY . .

# Bind the port that the image will run on
EXPOSE 8080

RUN npm run tsc

# Define the Docker image's behavior at runtime
CMD ["node", "./www/server.js"]