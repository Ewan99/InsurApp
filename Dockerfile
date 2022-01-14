FROM node:12
WORKDIR /InsurApp
COPY package.json .
RUN npm install
RUN npm install fabric-network
COPY . .
CMD node index.js
EXPOSE 3080
