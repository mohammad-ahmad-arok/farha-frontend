class EventMemberModel {
  final int id;
  final String arName;
  final String enName;
  final String gender;
  final int eventId;
  final int importance;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventMemberModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.gender,
    required this.eventId,
    required this.importance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventMemberModel.fromJson(Map<String, dynamic> json) {
    return EventMemberModel(
      id: json['id'],
      arName: json['ar_name'],
      enName: json['en_name'],
      gender: json['gender'],
      eventId: json['event_id'],
      importance: json['importance'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ar_name': arName,
      'en_name': enName,
      'gender': gender,
      'event_id': eventId,
      'importance': importance,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}