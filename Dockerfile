FROM siteslave/nginx-nodejs

LABEL maintainer="Satit Rianpit <rianpit@gmail.com>"

WORKDIR /home/queue

RUN npm i pm2 -g

RUN git clone https://github.com/mophos/queue-web-dmh

RUN git clone https://github.com/mophos/queue-api-dmh

RUN git clone https://github.com/mophos/queue-mqtt

RUN cd queue-web-dmh && npm i && npm run build && cd ..

RUN cd queue-api-dmh && npm i && npm i mssql@4.1.0 && npm run build && cd ..

RUN cd queue-mqtt && npm i && cd ..

COPY nginx.conf /etc/nginx/

COPY process.json .

CMD /usr/sbin/nginx && pm2-runtime process.json
