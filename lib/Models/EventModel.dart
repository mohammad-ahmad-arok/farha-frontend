import '../Screens/EventPreparing/MyEvents.dart';
import '../Shared/Components/EventPreparation/PreparationComponents.dart';
import 'EventMemberModel.dart';

class EventModel {
  final int id;
  final String arName;
  final String enName;
  final int displayOrder;
  final String eventType;
  final String? picture;
  final String? logo;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<EventMemberModel> eventMembers;

  EventModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.displayOrder,
    required this.eventType,
    this.picture,
    this.logo,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.eventMembers,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      arName: json['ar_name'],
      enName: json['en_name'],
      displayOrder: json['display_order'],
      eventType: json['event_type'],
      picture: json['picture'],
      logo: json['logo'],
      note: json['note'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      eventMembers: (json['eventMembers'] as List)
          .map((memberJson) => EventMemberModel.fromJson(memberJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ar_name': arName,
      'en_name': enName,
      'display_order': displayOrder,
      'event_type': eventType,
      'picture': picture,
      'logo': logo,
      'note': note,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'eventMembers': eventMembers.map((member) => member.toJson()).toList(),
    };
  }
}
class EventResponse {
  final bool success;
  final String message;
  final List<EventModel> data;

  EventResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: (json['data'] as List?)
          ?.map((e) => EventModel.fromJson(e))
          .toList() ?? [],
    );
  }

}
extension EventStatusExtension on EventModel {
  EventStatus get status {
    final now = DateTime.now();
    // إذا انتهى الوقت (أو وصل الإنجاز لـ 100% يمكنك إضافة هذا الشرط)
    if (updatedAt.isBefore(now.subtract(const Duration(days: 30)))) {
      return EventStatus.finished;
    } else if (createdAt.isAfter(now.subtract(const Duration(days: 1)))) {
      return EventStatus.upcoming;
    } else {
      return EventStatus.current;
    }
  }
}