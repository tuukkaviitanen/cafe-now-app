import 'package:cafe_now_app/screens/cafe_details_screen.dart';
import 'package:cafe_now_app/screens/cafe_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
        path: CafeSearchScreen.route,
        builder: (context, state) => const CafeSearchScreen(),
        routes: [
          GoRoute(
            path: CafeDetailsScreen.route,
            builder: (context, state) => const CafeDetailsScreen(),
          ),
        ]),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
          primarySwatch: Colors.orange,
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color.fromRGBO(255, 190, 152, 1),
              onPrimary: Colors.black,
              secondary: Color.fromRGBO(254, 236, 226, 1),
              onSecondary: Colors.black,
              error: Colors.deepOrangeAccent,
              onError: Colors.black,
              background: Color.fromRGBO(254, 236, 226, 1),
              onBackground: Colors.black,
              surface: Color.fromRGBO(247, 222, 208, 1),
              onSurface: Colors.black)),
    );
  }
}
