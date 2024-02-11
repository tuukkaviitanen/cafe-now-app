FROM node:18-alpine

RUN npm install -g @mockoon/cli@6.2.0
COPY ./nearby-places-mock-api.json ./nearby-places-mock-api.json
COPY ./nearby-places-mock-response.json ./nearby-places-mock-response.json


# Install curl for healthcheck and tzdata for timezone support.
RUN apk --no-cache add curl tzdata

# Do not run as root.
RUN adduser --shell /bin/sh --disabled-password --gecos "" mockoon
RUN chown -R mockoon ./nearby-places-mock-api.json
USER mockoon

EXPOSE 3000

ENTRYPOINT ["mockoon-cli","start","--disable-log-to-file","--data","./nearby-places-mock-api.json","--port","3000"]

# Usage: docker run -p <host_port>:<container_port> mockoon-test