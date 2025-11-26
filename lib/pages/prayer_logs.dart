import 'package:flutter/material.dart';
import 'package:waypoint_frontend/data/models/prayer_log_model.dart';
import 'package:waypoint_frontend/data/services/prayer_log_service.dart';

class PrayerLogsPage extends StatefulWidget {
  @override
  _PrayerLogsPageState createState() => _PrayerLogsPageState();
}

class _PrayerLogsPageState extends State<PrayerLogsPage> {
  List<PrayerLog> logs = [];
  bool selecting = false;
  List<String> selectedIds = [];

  @override
  void initState() {
    super.initState();
    loadLogs();
  }

  Future<void> loadLogs() async {
    logs = await PrayerLogService.getLogs();
    setState(() {});
  }

  // Add new log
  void showAddNoteDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Prayer Log"),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(hintText: "Enter your prayer note..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) return;
              await PrayerLogService.addLog(controller.text.trim());
              Navigator.pop(context);
              loadLogs();
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  // View log detail
  void showLogDetail(PrayerLog log) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Prayer Log"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Created: ${log.createdAt}",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(log.content),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  // Delete logs
  void deleteSelected() async {
    await PrayerLogService.deleteLogs(selectedIds);
    setState(() {
      selecting = false;
      selectedIds.clear();
    });
    loadLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer Logs"),
        actions: [
          if (selecting)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: selectedIds.isEmpty ? null : deleteSelected,
            ),
        ],
      ),
      body: logs.isEmpty
          ? Center(child: Text("No logs yet."))
          : ListView.builder(
        itemCount: logs.length,
        itemBuilder: (_, index) {
          final log = logs[index];
          final isSelected = selectedIds.contains(log.id);

          return ListTile(
            title: Text(
              log.content.length > 40
                  ? log.content.substring(0, 40) + "..."
                  : log.content,
            ),
            subtitle: Text(log.createdAt),
            trailing: selecting
                ? Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true)
                    selectedIds.add(log.id);
                  else
                    selectedIds.remove(log.id);
                });
              },
            )
                : null,
            onLongPress: () {
              setState(() {
                selecting = true;
                selectedIds.add(log.id);
              });
            },
            onTap: selecting
                ? () {
              setState(() {
                if (isSelected)
                  selectedIds.remove(log.id);
                else
                  selectedIds.add(log.id);
              });
            }
                : () => showLogDetail(log),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddNoteDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
