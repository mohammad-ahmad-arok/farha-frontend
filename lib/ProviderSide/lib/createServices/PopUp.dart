import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Shared/Style/Colors.dart';
import '../shared/buttons.dart';
import '../shared/components.dart';

class Popup extends StatefulWidget {
  const Popup({super.key});

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            /// TOP IMAGES
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/topRight (2).webp",
                width: isLandscape ? size.width * 0.15 : size.width * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/topLeft (2).webp",
                width: isLandscape ? size.width * 0.2 : size.width * 0.3,
                fit: BoxFit.cover,
              ),
            ),

            /// BOTTOM IMAGES
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/bottomRight (2).webp",
                width: isLandscape ? size.width * 0.1 : size.width * 0.15,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/bottomLeft (2).webp",
                width: isLandscape ? size.width * 0.1 : size.width * 0.15,
                fit: BoxFit.cover,
              ),
            ),

            /// CENTER CONTENT
            Center(
              child: SingleChildScrollView(
                // إضافة Padding بسيط لضمان عدم تداخل النص مع صور الزوايا في الشاشات الصغيرة جداً
                padding: EdgeInsets.symmetric(vertical: isLandscape ? 20 : 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/center.png",
                      // في التدوير، نعتمد على الارتفاع بدلاً من العرض لمنع تضخم الصورة
                      width: isLandscape ? size.height * 0.3 : size.width * 0.5,
                    ),
                    SizedBox(height: size.height * 0.02),

                    IntroSecondText(
                      subtitle: "تم إضافة خدمة بنجاح",
                      color: dark,
                      size: isLandscape ? 22 : size.width * 0.065,
                    ),
                    const SizedBox(height: 6),

                    IntroSecondText(
                      subtitle: "تم حفظ خدمتك وإتاحتها للعرض حسب إعدادات الظهور",
                      color: secondText,
                      size: isLandscape ? 14 : size.width * 0.035,
                    ),
                    const SizedBox(height: 4),

                    IntroSecondText(
                      subtitle: "التي اخترتها.يمكنك الأن تعديلها أو إضافة خدمة",
                      color: secondText,
                      size: isLandscape ? 14 : size.width * 0.035,
                    ),
                    const SizedBox(height: 4),
                    IntroSecondText(
                      subtitle: "جديدة في أي وقت.",
                      color: secondText,
                      size: isLandscape ? 14 : size.width * 0.035,
                    ),
                    SizedBox(height: isLandscape ? 15 : size.height * 0.03),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        // منع الزر من التمدد بشكل مفرط في وضع التدوير
                        constraints: BoxConstraints(maxWidth: isLandscape ? 350 : double.infinity),
                        child: BigIntroButton(
                          title: "عرض الخدمة",
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    IntroTextButton(title: "العودة للخدمات", size: 16)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}