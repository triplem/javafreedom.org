FROM node:alpine3.14

RUN mkdir -p /opt/lunr
RUN mkdir -p /tmp/lunr

WORKDIR /opt/lunr
RUN npm install lunr
RUN npm install lunr-languages

COPY assets/lunr-index.js /opt/lunr
CMD cat /tmp/lunr/lunr.json | node /opt/lunr/lunr-index.js > /tmp/lunr/lunr-index.json
