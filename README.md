# Cafe now app

> Mobile application for finding the nearest cafes closest to you!

### Summary

The application is created with [Flutter](https://flutter.dev/) and can be built for Windows, iOS and Android. The application finds the users location using GPS, and asks the intermediary server for the 20 nearest cafes. Then it renders each cafe on the map, and shows a list of them on the bottom half of the screen. Single cafe details page can be opened there for more information and a link to the device's default navigation app.

### Demo video

https://github.com/tuukkaviitanen/cafe-now-app/assets/97726090/e9b6310e-dc7b-4ba5-9d7b-33c43f695fc4

### Map

[flutter_map](https://pub.dev/packages/flutter_map) plugin is used to create the map on the screen. flutter_map uses the [latlong2](https://pub.dev/packages/latlong2) coordinate plugin for handling coordinates. [OpenStreetMap](https://www.openstreetmap.org/about) "hot" map tile is used for the map background. [geolocator](https://pub.dev/packages/geolocator) plugin is used to access the device's location, after getting the user's permission with [permission_handler](https://pub.dev/packages/permission_handler) plugin.

### Animations

Flutter is an excellent choice for creating beautiful animations easily. It offers many built-in animation features. This application uses [flutter_map_animations](https://pub.dev/packages/flutter_map_animations) plugin for animating the map movement and map markers. [scrollable_positioned_list](https://pub.dev/packages/scrollable_positioned_list) plugin is used to animate scrolling on the list of cafes. Flutter built-in [Hero animations](https://docs.flutter.dev/ui/animations/hero-animations) are used to animate the transition from map screen to details screen.

### Other notable use of plugins

- [go_router](https://pub.dev/packages/go_router) is used to create a great routing system for the application
- [json_serializer](https://pub.dev/packages/json_serializer) is a great package for parsing complicated [JSON](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON) data into dart classes
- [http](https://pub.dev/packages/http) is used for making HTTP requests
- [maps_launcher](https://pub.dev/packages/maps_launcher) is used to launch the device's default maps application (or the one that the user selects)
- [url_launcher](https://pub.dev/packages/url_launcher) is used for launching web urls in the device's default browser
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) is used to change the application's launcher icons easily on multiple platforms at once
- [rename_app](https://pub.dev/packages/rename_app) is used for renaming the app on multiple platforms at once
  - Although renaming on Windows required some manual fixing (see commit 0.0.12 for details)
