import 'package:flutter/material.dart';
import 'package:waypoint_frontend/pages/pages.dart'; // all pages in one import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: BottomNav(), // Use MainScreen with bottom nav
      routes: {
        '/prayerLogs':(context) => PrayerLogsPage(),
        '/readingPlans': (context) => ReadingPlans(),
        '/answeredPrayers': (context) => AnsweredPrayers(),
        '/aboutChurch': (context) => AboutChurch(),
        '/lyrics': (context) => Lyrics()
      },
    );
  }
}
