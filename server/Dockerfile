FROM oven/bun:latest AS build-stage

WORKDIR /usr/src/app

COPY package.json bun.lockb ./

RUN bun install --frozen-lockfile

COPY . .

RUN bun run build

FROM oven/bun:latest

WORKDIR /usr/src/app

COPY --from=build-stage /usr/src/app/out/ .

CMD [ "bun", "index.js" ]
