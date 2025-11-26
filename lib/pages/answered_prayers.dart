import 'package:flutter/material.dart';
import 'package:waypoint_frontend/constants/colors.dart';
import 'package:waypoint_frontend/data/models/answered_prayer_model.dart';
import 'package:waypoint_frontend/data/services/answered_prayer_service.dart';

class AnsweredPrayers extends StatefulWidget {
  @override
  _AnsweredPrayersPageState createState() => _AnsweredPrayersPageState();
}

class _AnsweredPrayersPageState extends State<AnsweredPrayers> {
  List<AnsweredPrayer> logs = [];
  bool selecting = false;
  List<String> selectedIds = [];

  @override
  void initState() {
    super.initState();
    loadLogs();
  }

  Future<void> loadLogs() async {
    logs = await AnsweredPrayerService.getLogs();
    setState(() {});
  }

  // Add new log
  void showAddNoteDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Answered Prayer"),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(hintText: "Enter your note..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) return;
              await AnsweredPrayerService.addLog(controller.text.trim());
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
  void showLogDetail(AnsweredPrayer log) {
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
    await AnsweredPrayerService.deleteLogs(selectedIds);
    setState(() {
      selecting = false;
      selectedIds.clear();
    });
    loadLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackground,
      appBar: AppBar(
        title: Text("Answered Prayers"),
        backgroundColor: primaryBackground,
        actions: [
          if (selecting)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: selectedIds.isEmpty ? null : deleteSelected,
            ),
        ],
      ),
      body: logs.isEmpty
          ? Center(child: Text("No items yet."))
          : ListView.builder(
        itemCount: logs.length,
        itemBuilder: (_, index) {
          final log = logs[index];
          final isSelected = selectedIds.contains(log.id);

          return ListTile(
            title: Text(
              log.content.length > 40
                  ? "${log.content.substring(0, 40)}..."
                  : log.content,
            ),
            subtitle: Text(log.createdAt),
            trailing: selecting
                ? Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    selectedIds.add(log.id);
                  } else {
                    selectedIds.remove(log.id);
                  }
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
                if (isSelected) {
                  selectedIds.remove(log.id);
                } else {
                  selectedIds.add(log.id);
                }
              });
            }
                : () => showLogDetail(log),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryBackground,
        onPressed: showAddNoteDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
