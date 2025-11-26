import 'package:waypoint_frontend/pages/answered_prayers.dart';
class AnsweredPrayer {
  final String id;
  final String content;
  final String createdAt;

  AnsweredPrayer({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "createdAt": createdAt,
  };

  static AnsweredPrayer fromJson(Map<String, dynamic> json) => AnsweredPrayer(
    id: json["id"],
    content: json["content"],
    createdAt: json["createdAt"],
  );
}
