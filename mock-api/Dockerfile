FROM oven/bun:latest

WORKDIR /usr/src/app

COPY template-data.json .

EXPOSE 3000

CMD ["bunx", "json-server", "template-data.json"]
