# Cafe now app

> Mobile application for finding the nearest cafes closest to you!

**DISCLAIMER:** This is just a student technical demo, and not for distribution. The Google Maps API key used is no longer active. For a distributed version, the map tile should be changed to one provided by Google Maps, to follow [Google Maps APIs Terms of Service](https://developers.google.com/maps/terms-20180207). Either that, or the places should be acquired from another provider.

## Summary

Multi-platform-application with [Flutter](https://flutter.dev/) that communicates with the [Google Maps Places API](https://developers.google.com/maps/documentation/places/web-service/overview) through a [Bun](https://bun.sh/) server with an [Express](https://expressjs.com/) API that acts as a [backend-for-frontend](https://medium.com/mobilepeople/backend-for-frontend-pattern-why-you-need-to-know-it-46f94ce420b0). This is to avoid revealing the API key for the users and transform the response body to contain only the relevant information. The Google API key itself can be restricted to only work on certain endpoints, so it potentially could be used straight from the app, but creating the intermediary with [Bun](https://bun.sh/) was half the fun, and a great learning exercise.

## Flutter Application

### Summary

The application is created with [Flutter](https://flutter.dev/) and can be built for Windows, iOS and Android. The application finds the users location using GPS, and asks the intermediary server for the 20 nearest cafes. Then it renders each cafe on the map, and shows a list of them on the bottom half of the screen. Single cafe details page can be opened there for more information and a link to the device's default navigation app.

### Demo



### Map

[flutter_map](https://pub.dev/packages/flutter_map) plugin is used to create the map on the screen. flutter_map uses the [latlong2](https://pub.dev/packages/latlong2) coordinate plugin for handling coordinates. [OpenStreetMap](https://www.openstreetmap.org/about) "hot" map tile is used for the map background. [geolocator](https://pub.dev/packages/geolocator) plugin is used to access the device's location, after getting the user's permission with [permission_handler](https://pub.dev/packages/permission_handler) plugin.

### Animations

Flutter is excellent choice for creating beautiful animations easily. This application uses [flutter_map_animations](https://pub.dev/packages/flutter_map_animations) plugin for animating the map movement and map markers. [scrollable_positioned_list](https://pub.dev/packages/scrollable_positioned_list) plugin is used to animate scrolling on the list of cafes. Flutter built-in [Hero animations](https://docs.flutter.dev/ui/animations/hero-animations) are used to animate the transition from map screen to details screen.

### Other notable use of plugins

- [go_router](https://pub.dev/packages/go_router) is used to create a great routing system for the application
- [json_serializer](https://pub.dev/packages/json_serializer) is a great package for parsing complicated [JSON](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON) data into dart classes
- [http](https://pub.dev/packages/http) is used for making HTTP requests
- [maps_launcher](https://pub.dev/packages/maps_launcher) is used to launch the device's default maps application (or the one that the user selects)
- [url_launcher](https://pub.dev/packages/url_launcher) is used for launching web urls in the device's default browser
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) is used to change the application's launcher icons easily on multiple platforms at once
- [rename_app](https://pub.dev/packages/rename_app) is used for renaming the app on multiple platforms at once
  - Although renaming on Windows required some manual fixing (see commit 0.0.12 for details)

## Server

### Bun Runtime

The server is created with [Bun](https://bun.sh/); a [JavaScript](https://developer.mozilla.org/en-US/docs/Web/javascript) runtime that is an alternative for [Node.js](https://nodejs.org/en). Bun is a relatively new runtime that has the advantage of being able to compile [TypeScript](https://www.typescriptlang.org/) at runtime without separate packages needed.

Bun also includes it's own package manager that is multiple times faster than [npm](https://www.npmjs.com/). It offers other great tools like a [jest](https://jestjs.io/)-like test runner and a bundler that can package your applications to a minified single JavaScript file. It also automatically reads your .env files and includes hot reload for development. I have been wanting to try out these features for a long time.

Being a new runtime and all, I have found issues with Bun as well. Not all dependencies run perfectly on Bun. I have tried to run Node based command line tools in [Bun docker images](https://hub.docker.com/r/oven/bun/tags), and at least [mockoon-cli](https://mockoon.com/cli/) is not installing properly. Also this project crashes on any slim, alpine or distroless Bun images.

I would use and recommend Bun for smaller TypeScript projects, because of it's easy and fast setup process. Anything with more complicated and bigger dependencies might start causing issues down the line, so I still wouldn't use it for any larger production projects.

### Google Places API

The server works as a proxy (or middleman) when fetching [nearby places](https://developers.google.com/maps/documentation/places/web-service/search-nearby) from [Google Maps Places API](https://developers.google.com/maps/documentation/places/web-service/overview). Server validates all requests made by the client and fetches the data from the Places API using an API key stored on the server. This way the API key will not be accessible to the user. After the data is fetched, the server checks that the data is valid and returns it to client.

[Zod](https://zod.dev/)-library is used for validating the data from the client AND the Places API. This is a way to ensure type safety even at runtime, as [TypeScript](https://www.typescriptlang.org/) types are removed at compile-time.

Google Places API key can be generated by following [these steps](https://developers.google.com/workspace/guides/create-credentials#:~:text=To%20create%20an%20API%20key%3A%201%20In%20the,%22API%20keys%22%20section%20of%20your%20project%27s%20credentials.%20). The Places API is free of charge to a point, but you can find more about the pricing model from [here](https://mapsplatform.google.com/pricing/).

### Mock API

Every fetch from the actual [Google Maps Places API](https://developers.google.com/maps/documentation/places/web-service/overview) consts credits, so a [Mock API](https://www.wiremock.io/glossary/mock-api#:~:text=The%20short%20answer%3A%20A%20mock%20API%20is%20a,real%20API%2C%20used%20primarily%20for%20testing%20and%20development) is created for testing and running the server in develpoment.

First I used a simple [json-server](https://github.com/typicode/json-server) to serve the mock data from a [JSON](https://en.wikipedia.org/wiki/JSON)-file. This is easily containerized as well. After a while I migrated to using [Mockoon](https://mockoon.com/). Mockoon provides a GUI as well as a CLI for creating even really complex Mock-APIs. Mockoon also promises a [GitHub actions](https://docs.github.com/en/actions) action that I later found out is not supported actively and doesn't work in the newest versions.

### Tests

Integration tests are created for the server API endpoint. These tests are using [Bun test runner](https://bun.sh/docs/cli/test). It feels like [Jest](https://jestjs.io/) and comes with bun without any configuring.

### CI Pipeline

There is a [GitHub actions](https://docs.github.com/en/actions) workflow configured for this repository that runs a [CI](https://en.wikipedia.org/wiki/CI/CD) pipeline for every pull request and merge to main branch. The pipeline run linter, builds the bundle and runs tests for the server. This ensures the quality of the main branch.

Pipeline runs [Mockoon](https://mockoon.com/) mock api before running the tests. Mockoon GitHub action isn't actively updated and is not functional with the latest [mockoon-cli](https://mockoon.com/cli/) version, so it's installed and run manually.

### Setup

#### Environtment

This server is intended to run on [Linux](https://en.wikipedia.org/wiki/Linux), so trying to run it on [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows) may cause issues. I personally use [Docker](https://www.docker.com/) inside [WSL Ubuntu](https://ubuntu.com/desktop/wsl) for running the develpoment setup with [docker compose](https://docs.docker.com/compose/), as this also runs the [Mock API](https://www.wiremock.io/glossary/mock-api#:~:text=The%20short%20answer%3A%20A%20mock%20API%20is%20a,real%20API%2C%20used%20primarily%20for%20testing%20and%20development). I run tests and the production version in WSL Ubuntu.

Before running any of the bun scripts, Bun should be installed on the machine. Follow the setup [here](https://bun.sh/docs/installation).

Docker should also be installed to follow the following steps. Install guide [here](https://docs.docker.com/engine/install/).

##### Environment variables

- PORT
  - Sets the port for the Express API
  - Defaults to 8080
- NODE_ENV
  - Mode the program is running in
  - `production`, `development` or `test`
  - Bun scripts and bun test set this accordingly
- GOOGLE_API_KEY
  - This is the API key used to fetch data from the [Google Maps Places API](https://developers.google.com/maps/documentation/places/web-service/overview)
  - Required when running the server on production mode with `bun start`
- MOCK_API_URL
  - URL for the Nearby Places Mock API (including the endpoint)
  - Required when running the server on development with `bun dev` or tests with `bun test`
    - This is already set when using docker-compose.dev.yml

See setup instructions below

#### Running the development mode and running tests

1. In the reposityory root directory, run: `docker-compose -f docker-compose.dev.yml up`
2. Wait for the terminal to display the log: `server-1    | Listening on port 8080`
3. Done. The API is now running in port 8080 on localhost

The docker compose runs the mock API and the server. All configuration is done in the docker-compose-file.

##### Running tests

1. While the docker compose is running, open another terminal (and keep the compose running)
2. Open `server` directory in your terminal
3. Run the command `bun test`

This runs all server tests while using the mock api still running in the docker container. The `.env.test` file configures the `MOCK_API_URL` to point to the mock api.

#### Running the production mode

1. Create `.env` file in the `server` directory
2. Add your Google Maps Places API key to the file as GOOGLE_API_KEY
 a. Check out .env.test for reference if not sure how to add environment variables
3. Open `server` directory in your terminal
4. Run the command `bun start`
5. Done. The API is now running in port 8080 on localhost

### Endpoints

These endpoints are available when running with locally with the default port of 8080:

```
GET http://localhost:8080/healthz
```

```
GET http://localhost:8080/nearbyCafes

Required query parameters:

latitude
longitude

Example full query:
http://localhost:8080/nearbyCafes?latitude=61.49911&longitude=23.78712
```
