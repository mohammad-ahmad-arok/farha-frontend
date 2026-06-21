class EventItemModel {
  int? userEventItemsId;
  int? supplierElementId;
  DateTime? startDateTime;
  DateTime? endDateTime;
  double? price;
  int? count;
  String? note;
  bool? withDelivery;

  EventItemModel({
    this.userEventItemsId,
    this.supplierElementId,
    this.startDateTime,
    this.endDateTime,
    this.price,
    this.count,
    this.note,
    this.withDelivery,
  });

  // تحويل من JSON إلى Model
  factory EventItemModel.fromJson(Map<String, dynamic> json) => EventItemModel(
    userEventItemsId: json["user_event_items_id"],
    supplierElementId: json["supplier_element_id"],
    startDateTime: json["start_date_time"] != null
        ? DateTime.parse(json["start_date_time"])
        : null,
    endDateTime: json["end_date_time"] != null
        ? DateTime.parse(json["end_date_time"])
        : null,
    price: json["price"]?.toDouble(),
    count: json["count"],
    note: json["note"],
    withDelivery: json["with_delivery"],
  );

  // تحويل من Model إلى JSON لإرساله للـ API
  Map<String, dynamic> toJson() => {
    "user_event_items_id": userEventItemsId,
    "supplier_element_id": supplierElementId,
    "start_date_time": startDateTime?.toIso8601String(),
    "end_date_time": endDateTime?.toIso8601String(),
    "price": price,
    "count": count,
    "note": note,
    "with_delivery": withDelivery,
  };
}