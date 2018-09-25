# base image
FROM node:9.6.1

# install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

# set working directory
RUN cd  /home
RUN mkdir reactapp
WORKDIR /home/reactapp

# add `/home/react/node_modules/.bin` to $PATH
ENV PATH /home/reactapp/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /home/reactapp/package.json
RUN npm install
RUN npm install -g react react-dom
RUN npm install -g create-react-app

# add app
COPY . /home/reactapp

# start app
CMD npm start
