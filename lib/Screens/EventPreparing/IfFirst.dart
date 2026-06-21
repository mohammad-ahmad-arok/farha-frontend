import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class Iffirst extends StatefulWidget {
  const Iffirst({super.key});

  @override
  State<Iffirst> createState() => _IffirstState();
}

class _IffirstState extends State<Iffirst> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    // استخدام shortestSide يضمن تناسق الأحجام والخطوط في كلتا الحالتين
    final double baseUnit = size.shortestSide;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                // لضمان التوسيط العمودي المطلق حتى في الشاشات الطويلة
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    // التوسيط العمودي داخل العمود
                    mainAxisAlignment: MainAxisAlignment.center,
                    // التوسيط الأفقي داخل العمود
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // هذا الـ SizedBox يضمن أن العمود يأخذ كامل عرض الشاشة للتوسيط الأفقي
                      const SizedBox(width: double.infinity),

                      // تعديل حجم الصورة بناءً على وضعية الشاشة
                      Image.asset(
                        "assets/IfFirst.webp",
                        width: isLandscape ? size.width * 0.15 : size.width * 0.30,
                      ),

                      SizedBox(height: isLandscape ? 15 : 30),

                      IntroSecondText(
                        subtitle: "أبدأ باختيار عناصر مناسبتك",
                        color: dark,
                        size: baseUnit * 0.055,
                      ),

                      const SizedBox(height: 12),

                      IntroSecondText(
                        subtitle: "اختار من القوائم كل ما تحتاجه لمناسبتك،\n      وسنساعدك بتنظيمها خطوة بخطوة",
                        color: orange,
                        size: baseUnit * 0.038,
                      ),

                      SizedBox(height: isLandscape ? 20 : 40),

                      // توسيط الزر في منتصف العرض
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          // في الروتيت الزر لا يتمدد لكامل العرض ليبقى شكله احترافياً
                          width: isLandscape ? size.width * 0.4 : double.infinity,
                          child: BigIntroButton(
                            onPressed: () {
                              // انتقل للشاشة التالية
                            },
                            title: 'التالي',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}