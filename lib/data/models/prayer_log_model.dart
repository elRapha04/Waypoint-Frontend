class PrayerLog {
  final String id;
  final String content;
  final String createdAt;

  PrayerLog({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "createdAt": createdAt,
  };

  static PrayerLog fromJson(Map<String, dynamic> json) => PrayerLog(
    id: json["id"],
    content: json["content"],
    createdAt: json["createdAt"],
  );
}
