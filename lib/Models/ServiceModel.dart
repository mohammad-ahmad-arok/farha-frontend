class ServiceModel {
  final String imageUrl;
  final String serviceName;
  final String description;
  final String duration;
  final double priceBeforeDiscount;
  final double? priceAfterDiscount;
  final double? discountPercent;
  final bool isFavorite;
  final String category;
  final String provider;
  final String specificType;
  final String eventType;

  ServiceModel({
    required this.imageUrl,
    required this.serviceName,
    required this.description,
    required this.duration,
  required this.category,
  required this.provider,
  required this.specificType,
  required this.eventType,
    required this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.discountPercent,
    this.isFavorite = false,
  });
}
