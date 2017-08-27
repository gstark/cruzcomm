FROM node

COPY signalmaster signalmaster
COPY WebRTC WebRTC

RUN cd signalmaster && npm install
RUN cd WebRTC && npm install

ENTRYPOINT cd WebRTC && npm run test-page
