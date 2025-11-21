import 'package:flutter/material.dart';
import 'package:opttrajflutter/services/api_service.dart';
import 'package:opttrajflutter/views/home_screen.dart';
import 'package:opttrajflutter/club_landing_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OptTraj Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => const LandingPage(),
        '/map': (context) => Provider(
              create: (_) => ApiService(),
              child: const HomeScreen(),
            ),
      },
      initialRoute: '/',
    );
  }
}
