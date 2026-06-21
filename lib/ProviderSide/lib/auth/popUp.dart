import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../Shared/Style/Colors.dart';
import '../shared/buttons.dart';
import '../shared/components.dart';

class Createventpopup extends StatefulWidget {
  const Createventpopup({super.key});

  @override
  State<Createventpopup> createState() => _CreateventpopupState();
}

class _CreateventpopupState extends State<Createventpopup> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack( // استخدام Stack لوضع الصور في الزوايا كخلفية
        children: [
          // 1. الصور في الزوايا (توزيعها كخلفية ثابتة)
          Positioned(
            top: 0, right: 0,
            child: Image.asset("assets/topRight (2).webp", width: size.width * (isLandscape ? 0.1 : 0.2)),
          ),
          Positioned(
            top: 0, left: 0,
            child: Image.asset("assets/topLeft (2).webp", width: size.width * (isLandscape ? 0.15 : 0.3)),
          ),
          Positioned(
            bottom: 0, right: 0,
            child: Image.asset("assets/bottomRight (2).webp", width: size.width * (isLandscape ? 0.08 : 0.15)),
          ),
          Positioned(
            bottom: 0, left: 0,
            child: Image.asset("assets/bottomLeft (2).webp", width: size.width * (isLandscape ? 0.08 : 0.15)),
          ),

          // 2. المحتوى المركزي
          SafeArea(
            child: Center(
              child: SingleChildScrollView( // لضمان السكرول إذا كانت الشاشة صغيرة جداً
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // تصغير الصورة المركزية في وضع الروتيت
                    Image.asset(
                      "assets/center.png",
                      width: isLandscape ? size.height * 0.3 : size.width * 0.5,
                    ),
                    SizedBox(height: isLandscape ? 10 : size.height * 0.02),

                    IntroSecondText(
                      subtitle: "تم إنشاء الحساب بنجاح",
                      color: dark,
                      size: isLandscape ? 20 : size.width * 0.055,
                    ),
                    const SizedBox(height: 6),

                    // نصوص الوصف
                    Column(
                      children: [
                        IntroSecondText(
                          subtitle: "سيتم مراجعة طلبك من قبل إدارة المنصة.",
                          color: secondText,
                          size: isLandscape ? 14 : size.width * 0.035,
                        ),
                        const SizedBox(height: 4),
                        IntroSecondText(
                          subtitle: "سيتم تفعيل الحساب بعد الموافقة وتسديد الإشتراك",
                          color: secondText,
                          size: isLandscape ? 14 : size.width * 0.035,
                        ),
                      ],
                    ),

                    SizedBox(height: isLandscape ? 15 : size.height * 0.04),

                    // الزر بعرض محدد في وضع الروتيت لكي لا يتمدد بشكل زائد
                    SizedBox(
                      width: isLandscape ? size.width * 0.4 : double.infinity,
                      child: BigIntroButton(
                        title: "حسنا",
                        onPressed: () {
                          // الأكشن هنا
                        },
                      ),
                    ),
                    // مسافة إضافية للسكرول في الروتيت
                    if (isLandscape) const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
