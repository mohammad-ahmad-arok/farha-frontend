import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';

Widget MainCard({
  required BuildContext context,
  required String title,
  required String subtitle,
  required VoidCallback? onPressed,
  required bool isLastScreen,
}) {
  final mediaQuery = MediaQuery.of(context);
  final isLandscape = mediaQuery.orientation == Orientation.landscape;
  final screenWidth = mediaQuery.size.width;
  final screenHeight = mediaQuery.size.height;

  // تحديد الارتفاع بذكاء: في الروتيت نعتمد على ارتفاع الشاشة وليس عرضها لمنع التضخم
  final double cardHeight = isLandscape ? screenHeight * 0.25 : screenWidth * 0.35;

  return Container(
    width: double.infinity,
    height: cardHeight,
    decoration: BoxDecoration(
      color: purple,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(isLandscape ? 20 : 40),
      ),
    ),
    child: Stack(
      children: [
        // زخرفة يسار (تصغيرها في الروتيت)
        Positioned(
          top: 0,
          left: 0,
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              "assets/whiteLeft.webp",
              width: isLandscape ? screenWidth * 0.12 : screenWidth * 0.25,
            ),
          ),
        ),

        // المحتوى
        SafeArea( // لضمان عدم التداخل مع النوتش في الروتيت
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // زر الرجوع
                  if (!isLastScreen)
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: isLandscape ? 35 : 45,
                      height: isLandscape ? 35 : 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: purple,
                          size: isLandscape ? 16 : 20,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),

                  const SizedBox(width: 15),

                  // النصوص
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: isLandscape ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        FittedBox( // يمنع النص من الخروج عن الحدود ويقوم بتصغيره تلقائياً
                          fit: BoxFit.scaleDown,
                          child: IntroText(
                            title: title,
                            color: light,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: light,
                            fontSize: isLandscape ? 11 : 13,
                            fontFamily: 'Cairo', // أو الخط المستخدم عندك
                          ),
                          maxLines: isLandscape ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: isLandscape ? TextAlign.start : TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // زخرفة يمين
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            "assets/whiteRight.webp",
            width: isLandscape ? screenWidth * 0.1 : screenWidth * 0.2,
          ),
        ),
      ],
    ),
  );
}
Widget SubscriptionCard(){
  return Container();
}
Widget WelcomeCard({
  required BuildContext context,
  required String userName,
}) {
  final mediaQuery = MediaQuery.of(context);
  final size = mediaQuery.size;
  final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

  // تحديد ارتفاع الكارت: في العرض نستخدم قيمة ثابتة، في الطول نستخدم نسبة
  final double cardHeight = isLandscape ? 100.0 : size.width * 0.35;

  // ضبط أحجام العناصر بناءً على وضع الشاشة
  final double iconSize = isLandscape ? 60.0 : cardHeight * 0.5;
  final double avatarRadius = isLandscape ? 25.0 : size.width * 0.07;
  final double notiSize = isLandscape ? 35.0 : size.width * 0.1;
  final double textSize = isLandscape ? 16.0 : size.width * 0.045;
  final double padding = isLandscape ? 12.0 : size.width * 0.04;

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      height: cardHeight,
      // تحديد عرض أقصى للكارت في وضع التابلت أو العرض الكبير
      constraints: const BoxConstraints(maxHeight: 180),
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(isLandscape ? 20 : cardHeight * 0.15),
          bottomLeft: Radius.circular(isLandscape ? 20 : cardHeight * 0.15),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none, // لمنع قص الصور إذا خرجت قليلاً
        children: [
          /// 🔹 المحتوى الرئيسي
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 👤 صورة المستخدم
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: const NetworkImage(''), // ضع رابط الصورة هنا
                    backgroundColor: Colors.white.withOpacity(0.3),
                  ),

                  SizedBox(width: isLandscape ? 10 : size.width * 0.03),

                  /// 👋 النص + الاسم (استخدمت Expanded لمنع Overflow في العرض الضيق)
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: textSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.white, // تم تغيير اللون للأبيض ليتناسب مع البنفسجي
                            fontFamily: 'BahijTheSansArabic',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "مرحباً",
                          style: TextStyle(
                            fontSize: textSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                            fontFamily: 'BahijTheSansArabic',
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔔 الإشعارات
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: notiSize,
                      height: notiSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(notiSize * 0.25),
                        child: Image.asset(
                          "assets/notifi.webp",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🎉 المفرقعات – يسار فوق
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/whiteLeft.webp',
                width: iconSize,
              ),
            ),
          ),

          /// 🎉 المفرقعات – يمين تحت
          Positioned(
            bottom: isLandscape ? 0 : 5,
            right: 0,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/whiteRight.webp',
                width: iconSize,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget smallWelcomeCard({
  required BuildContext context,
  required String userName,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // فحص إذا كان الجهاز في وضع التدوير (Landscape)
      bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

      final double width = MediaQuery.of(context).size.width;
      final double height = MediaQuery.of(context).size.height;

      // في الوضع العرضي نستخدم الارتفاع للحساب، وفي الطولي نستخدم العرض
      // هذا يمنع الكارت من التمدد بشكل مبالغ فيه
      final double referenceSize = isLandscape ? height : width;

      // تقليل النسبة في وضع التدوير ليكون أنحف
      final double cardHeight = isLandscape ? height * 0.25 : referenceSize * 0.30;

      final double iconSize = cardHeight * 0.6;
      final double textSize = isLandscape ? cardHeight * 0.2 : width * 0.05;
      final double paddingHorizontal = width * 0.06;

      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          height: cardHeight,
          decoration: BoxDecoration(
            color: purple,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(cardHeight * 0.2),
              bottomLeft: Radius.circular(cardHeight * 0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(cardHeight * 0.2),
              bottomLeft: Radius.circular(cardHeight * 0.2),
            ),
            child: Stack(
              children: [
                /// 🎉 المفرقعات – يسار فوق
                Positioned(
                  top: isLandscape ? -20 : -10,
                  left: -10,
                  child: Image.asset(
                    'assets/whiteLeft.webp',
                    width: iconSize,
                    fit: BoxFit.contain,
                  ),
                ),

                /// 🎉 المفرقعات – يمين تحت
                Positioned(
                  bottom: isLandscape ? -15 : -5,
                  right: -5,
                  child: Image.asset(
                    'assets/whiteRight.webp',
                    width: iconSize,
                    fit: BoxFit.contain,
                  ),
                ),

                /// 🔹 المحتوى الرئيسي (مُحاذى لليمين)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontSize: textSize,
                              fontWeight: FontWeight.w600,
                              color: dark,
                              fontFamily: 'BahijTheSansArabic',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}