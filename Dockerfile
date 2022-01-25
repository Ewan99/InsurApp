FROM node:12
WORKDIR /InsurApp
COPY package.json .
RUN npm install
RUN npm install fabric-network
COPY generatemsp.sh .
COPY generatemsp-tls.sh .
COPY . .
CMD node /public/index.js
EXPOSE 3080
