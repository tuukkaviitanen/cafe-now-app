FROM instrumentisto/flutter AS build-stage

WORKDIR /app

COPY . .

RUN flutter pub get --enforce-lockfile

RUN flutter build web

# Final image
FROM nginx:1.27

COPY --from=build /build/web /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf
