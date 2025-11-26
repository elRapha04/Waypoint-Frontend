import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String verseText = '"Loading verse..."';
  String verseInfo = ''; // Book + chapter:verse + version

  @override
  void initState() {
    super.initState();
    fetchRandomVerse();
  }

  Future<void> fetchRandomVerse() async {
    try {
      final response = await http.get(
        Uri.parse('https://biblebytopic.com/api/getrandompopularverse'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final verse = data['text'][0];

        final textKJV = verse['text-kjv']?.trim() ?? '';
        final book = verse['bookname'] ?? '';
        final chapter = verse['chapter']?.toString() ?? '';
        final startVerse = verse['startingverse']?.toString() ?? '';
        final endVerse = verse['endingverse']?.toString() ?? '';
        final version = data['version'] ?? '';

        // Combine start and end verse if needed
        String reference = startVerse;
        if (endVerse.isNotEmpty && endVerse != startVerse) {
          reference = '$startVerse-$endVerse';
        }

        setState(() {
          verseText = textKJV;
          verseInfo = '$book $chapter:$reference [$version]';
        });
      } else {
        setState(() {
          verseText = 'Failed to load verse.';
          verseInfo = '';
        });
      }
    } catch (e) {
      setState(() {
        verseText = 'Error loading verse.';
        verseInfo = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackground,
      appBar: AppBar(
        title: Text('WAYPOINT'),
        backgroundColor: primaryBackground,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Verse of the Day Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Verse of the Day',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Verse of the Day Content with background image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background image (daily changing)
                      Image.asset(
                        [
                          'assets/images/bg1.jpg',
                          'assets/images/bg2.jpg',
                          'assets/images/bg3.jpg',
                          'assets/images/bg4.jpg',
                          'assets/images/bg5.jpg',
                          'assets/images/bg6.jpg',
                        ][DateTime.now().difference(DateTime(DateTime.now().year)).inDays % 6],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),

                      // Black overlay
                      Container(
                        color: const Color(0xFF000000).withValues(alpha: 0.4),
                      ),

                      // Centered verse text
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                verseText, // no extra quotes
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                verseInfo,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Categories Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 2x2 Grid of Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildCategoryItem(context, 'Prayer Log', 'assets/images/prayerLogs.jpg', '/prayerLogs'),
                  buildCategoryItem(context, 'Reading Plan', 'assets/images/readingPlans.jpg', '/readingPlans'),
                  buildCategoryItem(context, 'Answered Prayers', 'assets/images/answeredPrayers.jpg', '/answeredPrayers'),
                  buildCategoryItem(context, 'About the Church', 'assets/images/aboutChurch.jpg', '/aboutChurch'),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Worship Lyrics Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/lyrics'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 120, // This ensures proper centering
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/lyrics.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),

                        Container(
                          color: const Color(0xFF000000).withValues(alpha: 0.4),
                        ),

                        Center(
                          child: Text(
                            'Worship Lyrics',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Helper method to build a category item
  Widget buildCategoryItem(
      BuildContext context,
      String title,
      String imagePath,
      String route,
      ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox.expand(
          child: Stack(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              Container(
                color: const Color(0xFF000000).withValues(alpha: 0.4),
              ),

              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
