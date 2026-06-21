import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../Style/Colors.dart';
import 'buttons.dart';
import 'components.dart';

Widget MainCard({
  required BuildContext context,
  required String title,
  required String subtitle,
  required VoidCallback? onPressed,
  required bool isLastScreen,
}) {
  final size = MediaQuery.of(context).size;
  final screenWidth = size.width;
  final screenHeight = size.height;
  final bool isLandscape = screenWidth > screenHeight;

  // ارتفاع الكارد
  final cardHeight = isLandscape ? screenHeight * 0.6 : screenWidth * 0.6;

  // تصغير حجم الصور بمقدار درجة واحدة عن السابق
  // (استخدمنا 0.3 و 0.18 بدلاً من 0.35 و 0.25)
  final double leftImageWidth = isLandscape ? screenHeight * 0.3 : screenWidth * 0.25;
  final double rightImageWidth = isLandscape ? screenHeight * 0.24 : screenWidth * 0.2;

  return Container(
    width: screenWidth,
    height: cardHeight,
    decoration: BoxDecoration(
      color: purple,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(cardHeight * 0.15),
      ),
    ),
    child: Stack(
      children: [
        // صورة أعلى يسار
        Positioned(
          top: isLandscape ? -10 : 0,
          left: isLandscape ? -10 : 0,
          child: Image.asset("assets/whiteLeft.webp", width: leftImageWidth),
        ),
        // صورة أعلى يمين
        Positioned(
          top: isLandscape ? -8 : 0,
          right: isLandscape ? -8 : 0,
          child: Image.asset("assets/whiteRight.webp", width: rightImageWidth),
        ),
        // صورة أسفل يسار
        Positioned(
          bottom: isLandscape ? -10 : 0,
          left: isLandscape ? -10 : 0,
          child: Image.asset("assets/whiteLeft.webp", width: leftImageWidth),
        ),
        // صورة أسفل يمين
        Positioned(
          bottom: isLandscape ? -8 : 0,
          right: isLandscape ? -8 : 0,
          child: Image.asset("assets/whiteRight.webp", width: rightImageWidth),
        ),

        // المحتوى الأساسي في المنتصف
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/white.webp",
                width: isLandscape ? screenHeight * 0.32 : screenWidth * 0.41,
              ),
              SizedBox(height: cardHeight * 0.05),
              IntroText(title: title, color: light),
              SizedBox(height: cardHeight * 0.03),
              IntroSecondText(subtitle: subtitle, color: light, size: 16),
            ],
          ),
        ),

        // زر الرجوع
        if (!isLastScreen)
          Positioned(
            right: screenWidth * 0.05,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: cardHeight * 0.18,
                height: cardHeight * 0.17,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(cardHeight * 0.05),
                ),
                child: IconButton(
                  onPressed: onPressed,
                  iconSize: cardHeight * 0.09,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(Icons.arrow_back_ios_outlined, color: purple),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
Widget HomeCard({
  required BuildContext context,
  required String title,
  required String subtitle,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final cardHeight = screenWidth * 0.6; // ارتفاع مرن

  return Container(
    width: screenWidth,
    height: cardHeight,
    decoration: BoxDecoration(
      color: purple,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(cardHeight * 0.15), // نسبة من الارتفاع
      ),
    ),
    child: Stack(
      children: [
        // زخرفة فوق يسار
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            "assets/whiteLeft.png",
            width: screenWidth * 0.25,
          ),
        ),

        // زخرفة فوق يمين
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            "assets/whiteRight.png",
            width: screenWidth * 0.2,
          ),
        ),
        // المحتوى الأساسي
        Padding(
          padding: EdgeInsets.only(left:screenWidth * 0.080,
            top:screenWidth * 0.090,), // نسبة من الشاشة
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right:screenWidth * 0.005),
                    child: Image.asset(
                      "assets/white.png",
                      width: screenWidth * 0.41,
                    ),
                  ),
                  SizedBox(height: cardHeight * 0.05),
                  IntroText(
                    title: title,
                    color: light,
                  ),
                  SizedBox(height: cardHeight * 0.03),
                  IntroSecondText(
                    subtitle: subtitle,
                    color: light, size:16,
                  )
                ],
              ),
              Container(
                width: cardHeight * 0.17, // نسبة من ارتفاع البطاقة
                height: cardHeight * 0.17,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(cardHeight * 0.05),
                ),
                child: IconButton(
                  onPressed: () {},
                  iconSize: cardHeight * 0.09,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: purple,
                  ),
                ),
              ),
            ],
          ),
        ),

        // زخرفة تحت يسار
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(
            "assets/whiteLeft.png",
            width: screenWidth * 0.25,
          ),
        ),

        // زخرفة تحت يمين
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            "assets/whiteRight.png",
            width: screenWidth * 0.2,
          ),
        ),
      ],
    ),
  );
}
Widget WelcomeCard({
  required BuildContext context,
  required String userName,
}) {
  final size = MediaQuery.of(context).size;
  final orientation = MediaQuery.of(context).orientation;
  final isLandscape = orientation == Orientation.landscape;

  // الحفاظ على الارتفاع الطبيعي للكارد (كما كان في البداية)
  final cardHeight = isLandscape
      ? size.height * 0.25   // 25% من ارتفاع الشاشة في الأفقي
      : size.width * 0.35;   // 35% من عرض الشاشة في العمودي

  // تصغير المحتويات الداخلية بشكل كبير
  final iconSize = cardHeight * 0.2;      // حجم أيقونة الإشعارات والزينة (كانت 0.4)
  final avatarRadius = cardHeight * 0.18;  // نصف قطر الأفاتار (كان 25 أو 20 ثابت)
  final fontSize = cardHeight * 0.14;       // حجم الخط (كان 16-18 ثابت)

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: purple,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // الأفاتار + النص
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.white70,
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        " مرحبا، $userNameً",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                    ],
                  ),
                  // أيقونة الإشعارات
                  Container(
                    padding: EdgeInsets.all(iconSize * 0.2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white70,
                    ),
                    child: Image.asset(
                      "assets/notifi.webp",
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // الزينة (تظهر فقط في الوضع العمودي)
          if (!isLandscape) ...[
            Positioned(
              top: 5,
              left: 5,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/whiteLeft.webp',
                  width: iconSize,
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/whiteRight.webp',
                  width: iconSize,
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

