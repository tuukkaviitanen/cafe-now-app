FROM instrumentisto/flutter:3.24 AS build-stage

WORKDIR /app

COPY . .

RUN flutter pub get --enforce-lockfile

RUN flutter build web --release

FROM nginx:1.27-alpine

COPY --from=build-stage /app/build/web /usr/share/nginx/html
