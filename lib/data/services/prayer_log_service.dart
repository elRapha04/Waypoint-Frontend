import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../models/prayer_log_model.dart';

class PrayerLogService {
  static const String storageKey = "prayer_logs";

  // Load existing logs
  static Future<List<PrayerLog>> getLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(storageKey);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => PrayerLog.fromJson(e)).toList();
  }

  // Save list
  static Future<void> saveLogs(List<PrayerLog> logs) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = logs.map((e) => e.toJson()).toList();
    prefs.setString(storageKey, jsonEncode(jsonList));
  }

  // Add a new log
  static Future<void> addLog(String content) async {
    final logs = await getLogs();
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(now); // 12-hour format

    final newLog = PrayerLog(
      id: now.millisecondsSinceEpoch.toString(),
      content: content,
      createdAt: formattedDate,
    );

    logs.add(newLog);
    await saveLogs(logs);
  }

  // Delete selected logs
  static Future<void> deleteLogs(List<String> ids) async {
    final logs = await getLogs();
    logs.removeWhere((log) => ids.contains(log.id));
    await saveLogs(logs);
  }
}
