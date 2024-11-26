FROM instrumentisto/flutter:3.24 AS build-stage

WORKDIR /app

COPY ./app .

RUN flutter pub get --enforce-lockfile

RUN flutter build web --release

FROM caddy:2.9-alpine AS final-stage

COPY --from=build-stage /app/build/web /srv

CMD [ "caddy", "file-server" ]
