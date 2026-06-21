import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import '../EventPreparing/TodoList1.dart';

class Completebooking extends StatefulWidget {
  const Completebooking({super.key});

  @override
  State<Completebooking> createState() => _CompletebookingState();
}

class _CompletebookingState extends State<Completebooking> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final double baseUnit = size.shortestSide;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // إلغاء SafeArea في الروتيت لتوفير مساحة للصور الجانبية
        top: false,
        bottom: false,
        child: Stack(
          children: [
            // ================== الصور الجانبية (خلفية) ==================
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/topRight.webp",
                      width: isLandscape ? size.width * 0.12 : size.width * 0.2,
                    ),
                    Image.asset(
                      "assets/topLeft.webp",
                      width: isLandscape ? size.width * 0.15 : size.width * 0.3,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/bottomRight.webp",
                      width: isLandscape ? size.width * 0.08 : size.width * 0.15,
                    ),
                    Image.asset(
                      "assets/bottomLeft.webp",
                      width: isLandscape ? size.width * 0.08 : size.width * 0.15,
                    ),
                  ],
                ),
              ],
            ),

            // ================== المحتوى الأساسي ==================
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // أيقونة الحجز (دائرة)
                      Container(
                        width: isLandscape ? size.height * 0.3 : size.width * 0.4,
                        height: isLandscape ? size.height * 0.3 : size.width * 0.4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF6ECF4),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/booking.webp",
                            width: isLandscape ? size.height * 0.2 : size.width * 0.25,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      IntroSecondText(
                        subtitle: "تم إرسال طلب الحجز",
                        color: dark,
                        size: isLandscape ? baseUnit * 0.06 : size.width * 0.06,
                      ),

                      SizedBox(height: size.height * 0.01),

                      // نصوص الوصف مع ضبط العرض في الروتيت لمنع التشتت
                      SizedBox(
                        width: isLandscape ? size.width * 0.6 : double.infinity,
                        child: Column(
                          children: [
                            IntroSecondText(
                              subtitle: "تم إرسال طلبك إلى مزود الخدمة بنجاح",
                              color: secondText,
                              size: isLandscape ? baseUnit * 0.035 : size.width * 0.04,
                            ),
                            const SizedBox(height: 4),
                            IntroSecondText(
                              subtitle: "سيتم إشعارك فور تأكيد الحجز أو في حال وجود تحديث",
                              color: secondText,
                              size: isLandscape ? baseUnit * 0.035 : size.width * 0.04,
                            ),
                            const SizedBox(height: 8),
                            IntroSecondText(
                              subtitle: "<<يمكنك متابعة حالة الطلب من صفحة المهام>>",
                              color: secondText,
                              size: isLandscape ? baseUnit * 0.035 : size.width * 0.04,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // الزر
                      SizedBox(
                        width: isLandscape ? size.width * 0.4 : double.infinity,
                        height: isLandscape ? 40 : size.height * 0.060,
                        child: IntroButton(
                          title: "متابعة تجهيز المناسبة",
                          onPressed: () {
                            Get.to(() => Todolist1(eventName: '', remainingDays: 0));
                          },
                        ),
                      ),

                      // مسافة أمان سفلية في الروتيت
                      if (isLandscape) SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}