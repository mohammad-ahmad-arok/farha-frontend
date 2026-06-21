import 'package:flutter/material.dart';
import '../../Style/Colors.dart';
import '../components.dart';

class RatingThinBars extends StatelessWidget {
  const RatingThinBars({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Column(
      children: [
        // استخدام مسافات رأسية بنسبة مئوية من ارتفاع الشاشة
        ThinRatingBar(stars: 5, percentage: 0.65, screenSize: size),
        ThinRatingBar(stars: 4, percentage: 0.20, screenSize: size),
        ThinRatingBar(stars: 3, percentage: 0.10, screenSize: size),
        ThinRatingBar(stars: 2, percentage: 0.03, screenSize: size),
        ThinRatingBar(stars: 1, percentage: 0.02, screenSize: size),
      ],
    );
  }
}

class ThinRatingBar extends StatelessWidget {
  final int stars;
  final double percentage;
  final Size screenSize; // مررنا الحجم هنا للحسابات

  const ThinRatingBar({
    super.key,
    required this.stars,
    required this.percentage,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    // المرجع للأحجام (الضلع الأصغر) لضمان عدم ضخامة العناصر في الروتيت
    final ref = screenSize.shortestSide;

    return Padding(
      // بادينج رأسي بنسبة 0.8% من أصغر ضلع للحفاظ على المسافات
      padding: EdgeInsets.symmetric(vertical: ref * 0.008),
      child: Row(
        children: [
          // عرض النص بنسبة مئوية (مثلاً 10% من أصغر ضلع)
          SizedBox(
            width: ref * 0.1,
            child: IntroSecondText(
              subtitle: '$stars★',
              color: orange,
              // حجم الخط كنسبة مئوية من أصغر ضلع
              size: ref * 0.04,
            ),
          ),

          // مسافة صغيرة بنسبة مئوية
          SizedBox(width: screenSize.width * 0.02),

          Expanded(
            child: ClipRRect(
              // حواف دائرية بنسبة مئوية
              borderRadius: BorderRadius.circular(ref * 0.02),
              child: LinearProgressIndicator(
                value: percentage,
                // ارتفاع البار بنسبة 1.5% من أصغر ضلع ليبقى رفيعاً دائماً
                minHeight: ref * 0.015,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}