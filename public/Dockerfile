FROM node:16
WORKDIR /usr/src/webapp/
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3080
CMD [ "node", "index.js" ]