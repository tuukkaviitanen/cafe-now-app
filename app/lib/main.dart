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
        primarySwatch: Colors.brown,
      ),
    );
  }
}
