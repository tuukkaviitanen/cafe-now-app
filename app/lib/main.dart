import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/screens/cafe_details_screen.dart';
import 'package:cafe_now_app/screens/cafe_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
            builder: (context, state) => CafeDetailsScreen(
              cafe: state.extra as Place?,
            ),
          ),
        ]),
  ],
);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static const Duration defaultAnimationDuration = Duration(milliseconds: 1000);

  static final defaultBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 4,
    blurRadius: 3,
    offset: const Offset(1, 2),
  );

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Cafe Now!",
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromRGBO(250, 195, 164, 1),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(255, 226, 210, 1),
            onSecondary: Colors.black,
            error: Colors.deepOrangeAccent,
            onError: Colors.black,
            surface: Color.fromRGBO(254, 236, 226, 1),
            onSurface: Colors.black),
        textTheme: GoogleFonts.dynaPuffTextTheme(
          const TextTheme(
            displayLarge: TextStyle(fontSize: 30.0),
            displayMedium: TextStyle(fontSize: 23.0),
            displaySmall: TextStyle(fontSize: 14.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(5),
            backgroundColor:
                WidgetStateProperty.all(const Color.fromRGBO(250, 195, 164, 1)),
            textStyle: WidgetStateProperty.all(
              const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
