import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import '../EventPreparing/MyEvents.dart';
import '../home-layout/Home-layout.dart';

class Createventpopup extends StatefulWidget {
  const Createventpopup({super.key});

  @override
  State<Createventpopup> createState() => _CreateventpopupState();
}

class _CreateventpopupState extends State<Createventpopup> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final double baseUnit = size.shortestSide; // هذا هو المرجع الأفضل للحجم
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    // تحديد أحجام الصور الجانبية بناءً على وضع الشاشة
    // في الروتيت، نستخدم قيم ثابتة صغيرة لتجنب الضخامة
    final double topRightWidth = isLandscape ? 60 : screenWidth * 0.2;
    final double topLeftWidth = isLandscape ? 80 : screenWidth * 0.3;
    final double bottomRightWidth = isLandscape ? 50 : screenWidth * 0.15;
    final double bottomLeftWidth = isLandscape ? 50 : screenWidth * 0.15;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// 1. الصور الموجودة في الزوايا (خلفية) - تم تعديل العرض هنا
          // صورة أعلى اليمين
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/topRight.webp", width: topRightWidth, fit: BoxFit.contain),
          ),
          // صورة أعلى اليسار
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("assets/topLeft.webp", width: topLeftWidth, fit: BoxFit.contain),
          ),
          // صورة أسفل اليمين
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/bottomRight.webp", width: bottomRightWidth, fit: BoxFit.contain),
          ),
          // صورة أسفل اليسار
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("assets/bottomLeft.webp", width: bottomLeftWidth, fit: BoxFit.contain),
          ),

          /// 2. المحتوى الأساسي
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  // زيادة البادينغ الرأسي قليلاً ليعطي مساحة في الروتيت
                  vertical: isLandscape ? 10 : 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // صورة المنتصف - جعلناها أصغر قليلاً في الروتيت لتبدو متناسقة
                    Image.asset(
                      "assets/center.webp",
                      width: isLandscape ? screenHeight * 0.28 : screenWidth * 0.5,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: isLandscape ? 15 : screenHeight * 0.03),

                    IntroSecondText(
                      subtitle: "تم إنشاء مناسبتك بنجاح",
                      color: dark,
                      size: baseUnit * 0.055,
                    ),
                    const SizedBox(height: 10),

                    // نصوص الوصف - دمجناها لتقليل المساحة الرأسية في الروتيت
                    _buildDescriptionText("يمكنك الآن البدء بتجهيز مناسبتك خطوة بخطوة", baseUnit),
                    _buildDescriptionText("سنساعدك على متابعة المهام والتذكير بكل ما تحتاجه", baseUnit),
                    _buildDescriptionText("في الوقت المناسب", baseUnit),

                    // تقليل المسافة الكبيرة في الروتيت
                    SizedBox(height: isLandscape ? 20 : 40),

                    // أزرار التحكم
                    SizedBox(
                      width: double.infinity,
                      child: BigIntroButton(
                        title: "أبدأ التجهيز",
                        onPressed: () => Get.to(const Myevents()),
                      ),
                    ),
                    const SizedBox(height: 10),

                    IntroTextButton(
                      title: "العودة للرئيسية",
                      size: baseUnit * 0.04,
                      onPressed: () => Get.offAll(const HomeLayout()),
                    ),

                    // بادينغ إضافي من الأسفل لضمان عدم تداخل الأزرار مع الصور في الشاشات الصغيرة جداً
                    SizedBox(height: isLandscape ? 30 : 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ميثود مساعدة لتقليل تكرار الكود في نصوص الوصف
  Widget _buildDescriptionText(String text, double baseUnit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: IntroSecondText(
        subtitle: text,
        color: secondText,
        size: baseUnit * 0.035,
      ),
    );
  }
}