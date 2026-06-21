import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../auth/LogIn.dart';
import '../auth/Users/UserRegister1.dart';

class Intro4 extends StatefulWidget {
  const Intro4({super.key});

  @override
  State<Intro4> createState() => _Intro4State();
}

class _Intro4State extends State<Intro4> {
  @override
  Widget build(BuildContext context) {
    // تم تغليف الـ Scaffold بـ PopScope لمنع الرجوع
    return PopScope(
      canPop: false, // هذا السطر يمنع الرجوع
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            double h = constraints.maxHeight;
            double w = constraints.maxWidth;
            bool isLandscape = w > h;

            return Stack(
              children: [
                // صور المفرقعات (ثابتة في الزوايا)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/right.webp",
                    width: isLandscape ? w * 0.15 : w * 0.35,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/left.webp",
                    width: isLandscape ? w * 0.15 : w * 0.35,
                  ),
                ),

                // المحتوى الرئيسي
                SizedBox(
                  width: w,
                  height: h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // توسيط عمودي لكل المحتوى
                    crossAxisAlignment: CrossAxisAlignment.center, // توسيط أفقي
                    children: [
                      // 1. الصورة
                      Image.asset(
                        "assets/intro4.webp",
                        height: isLandscape ? h * 0.25 : h * 0.38, // حجم متوازن
                        fit: BoxFit.contain,
                      ),
                      IntroText(
                        title: "🎉أهلاً بك في فرحة",
                        color: const Color(0xFF2C2F31),
                      ),
                      // 2. النصوص (العنوان والوصف)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            IntroSecondText(
                              subtitle: 'اختر الطريقة التي تود المتابعة بها وابدأ',
                              color: const Color(0xFF5F6368),
                              size: 15,
                            ),
                            IntroSecondText(
                              subtitle: 'رحلتك في تنظيم مناسباتك بكل سهولة',
                              color: const Color(0xFF5F6368),
                              size: 15,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: h * 0.05), // مسافة بين النصوص والأزرار

                      // 3. قسم الأزرار
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isLandscape ? w * 0.45 : w * 0.8,
                        ),
                        child: Column(
                          children: [
                            IntroButton(
                              title: "تسجيل الدخول",
                              onPressed: () => Get.to(() => const Login()),
                            ),
                            const SizedBox(height: 15),
                            IntroSecondText(
                              subtitle: 'أو',
                              color: const Color(0xFF5F6368),
                              size: 14,
                            ),
                            const SizedBox(height: 15),
                            IntroButtonOutlined(
                              title: "إنشاء حساب",
                              onPressed: () => Get.to(() => const UserRegister1()),
                            ),
                          ],
                        ),
                      ),

                      // الفراغ السفلي
                      SizedBox(height: isLandscape ? h * 0.1 : h * 0.12),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}