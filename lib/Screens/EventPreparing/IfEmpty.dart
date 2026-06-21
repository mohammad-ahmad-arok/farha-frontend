import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import '../EventDetails/EventDetails.dart';

class Ifempty extends StatelessWidget {
  const Ifempty({super.key});

  @override
  Widget build(BuildContext context) {
    // جلب أبعاد الشاشة
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Center( // يتوسط الشاشة أفقياً وعمودياً
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى داخل العمود
              mainAxisSize: MainAxisSize.min, // العمود يأخذ حجم محتواه فقط
              children: [
                Image.asset(
                  "assets/center.webp",
                  // تم تغيير العرض إلى ارتفاع محدد لضمان التصغير الفعلي
                  height: size.height * 0.10, // جعل ارتفاع الصورة 10% من طول الشاشة
                  fit: BoxFit.contain, // يضمن بقاء النسبة الأصلية للصورة
                ),
                SizedBox(height: size.height * 0.03),

                IntroSecondText(
                  subtitle: "ابدأ أول مناسبة لك",
                  color: dark,
                  size: size.width * 0.055,
                ),
                const SizedBox(height: 12),

                IntroSecondText(
                  subtitle: "أنشئ مناسبتك وابدأ بتنظيم كل التفاصيل خطوة بخطوة",
                  color: orange,
                  size: size.width * 0.035,
                ),

                SizedBox(height: size.height * 0.04),

                BigIntroButton(
                  title: "إنشاء مناسبة جديدة ➕",
                  onPressed: () {
                    Get.to(() => const Eventdetails());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}