import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Shared/Style/Colors.dart';
import '../shared/buttons.dart';
import '../shared/components.dart';

class EventDetailsBottomSheet extends StatelessWidget {
  final String imageUrl;
  final String serviceName;
  final String description;
  final String duration;
  final double priceBeforeDiscount;
  final double? priceAfterDiscount;
  final List<String> images;
  final String provider;

  const EventDetailsBottomSheet({
    super.key,
    required this.imageUrl,
    required this.serviceName,
    required this.description,
    required this.duration,
    required this.priceBeforeDiscount,
    this.priceAfterDiscount,
    required this.images,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.74,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // المقبض العلوي
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // سكرول الصور
                    SizedBox(
                      height: size.height * 0.25,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                                width: size.width * 0.85,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left:size.width * 0.05,
                      right:size.width * 0.05,
                        top:size.width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          IntroText(title: serviceName, color: dark),
                          const SizedBox(height: 15),

                          // السعر
// السعر مع نسبة الخصم
                          Row(
                            children: [
                              IntroSecondText(subtitle: "السعر:", color: dark, size: 16),
                              const SizedBox(width: 10),
                              if (priceAfterDiscount != null) ...[
                                // السعر بعد الخصم
                                IntroSecondText(subtitle: "S.P $priceAfterDiscount", color: orange, size: 18),
                                const SizedBox(width: 10),

                                // كونتينة نسبة الخصم
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: orange.withOpacity(0.1), // لون خفيف خلف النص
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: orange, width: 0.5),
                                  ),
                                  child: Text(
                                    "-${((1 - (priceAfterDiscount! / priceBeforeDiscount)) * 100).toStringAsFixed(0)}%",
                                    style: TextStyle(
                                      color: orange,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                // السعر القديم مشطوب
                                Text(
                                  "$priceBeforeDiscount S.P",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14,
                                  ),
                                ),
                              ] else ...[
                                IntroSecondText(subtitle: "S.P $priceBeforeDiscount", color: orange, size: 16),
                              ],
                            ],
                          ),
                          const SizedBox(height: 20),

                          // الوصف
                          IntroSecondText(
                            subtitle: description,
                            color: Colors.grey[600]!,
                            size: 15,
                          ),

                          const SizedBox(height: 25),

                          // مدة التنفيذ
                          Row(
                            children: [
                              Icon(Icons.watch_later_outlined, color: dark, size: 22),
                              const SizedBox(width: 8),
                              IntroSecondText(subtitle: "مدة التنفيذ : $duration", color: dark, size: 16),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ================== قسم تفاصيل الخدمة الجديد ==================
                          IntroSecondText(subtitle: "تفاصيل الخدمة", color: dark, size: 18),
                          const SizedBox(height: 15),

                          _buildDetailRow("النمط:", "عصري / Modern"),
                          _buildDetailRow("النوع:", "خدمة مميزة"),
                          _buildDetailRow("اللون:", "أبيض ملكي"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget مساعد لعرض أسطر التفاصيل بشكل مرتب
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          IntroSecondText(subtitle:label, color:dark, size:14),
          const SizedBox(width: 10),
          IntroSecondText(subtitle:value, color:secondText, size:13),
        ],
      ),
    );
  }
}