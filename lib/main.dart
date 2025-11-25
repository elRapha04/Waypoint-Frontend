import 'package:flutter/material.dart';
import 'package:waypoint_frontend/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: HomePage(),

      routes: {
        '/prayerLogs':(context) => PrayerLogs(),
        '/readingPlans': (context) => ReadingPlans(),
        '/answeredPrayers': (context) => AnsweredPrayers(),
        '/aboutChurch': (context) => AboutChurch(),
        '/lyrics': (context) => Lyrics()
      },
    );
  }
}