import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Style/Colors.dart';
import '../EventPreparation/PreparationComponents.dart';
import '../buttons.dart';
import '../components.dart';
String? selectedRole;

Container AppBarEventDetails(
    BuildContext context,
    String title, {
      String? time,
      bool showTime = false,
      bool showLeftButton = true,
    }) {
  final size = MediaQuery.of(context).size;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  // --- التعديل هنا لزيادة الارتفاع في الروتيت عند ظهور الوقت ---
  double appBarHeight;
  if (isPortrait) {
    appBarHeight = size.height * 0.1; // الارتفاع الطبيعي في الوضع الطولي
  } else {
    // إذا كان روتيت والوقت معروض، نزيد الارتفاع لـ 85، وإذا لا يبقى 65
    appBarHeight = showTime ? 85.0 : 65.0;
  }

  final baseScale = isPortrait ? size.width : size.height;

  return Container(
    width: double.infinity,
    height: appBarHeight,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: SafeArea(
      bottom: false, // لا نحتاج بادينج سفلي داخل الـ AppBar
      child: Row(
        children: [
          /// زر الرجوع
          Padding(
            padding: EdgeInsets.symmetric(horizontal: baseScale * 0.04),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: isPortrait ? size.width * 0.1 : 40,
                height: isPortrait ? size.width * 0.1 : 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: isPortrait ? size.width * 0.045 : 18,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          /// العنوان + الوقت
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntroSecondText(
                  subtitle: title,
                  color: dark,
                  size: isPortrait ? size.width * 0.045 : 16,
                ),
                if (showTime && time != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4), // زيادة بسيطة في المسافة
                    child: IntroSecondText(
                      subtitle: "باقي $time يوم ⏳",
                      color: orange,
                      size: isPortrait ? size.width * 0.035 : 13, // تكبير الخط قليلاً في الروتيت
                    ),
                  ),
              ],
            ),
          ),

          /// زر المشاركة
          if (showLeftButton)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: baseScale * 0.04),
              child: InkWell(
                onTap: () => showSharePopup(context: context),
                child: Container(
                  width: isPortrait ? size.width * 0.1 : 40,
                  height: isPortrait ? size.width * 0.1 : 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/share.webp",
                      width: isPortrait ? 18 : 16,
                      height: isPortrait ? 18 : 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
Widget AddPeopleCard({
  required String? selectedRole,
  required Function(String?) onChanged,
}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              radius: 25,
            ),
            SizedBox(width: 5),
            IntroSecondText(
              subtitle: "اسم المستخدم",
              color: dark,
              size: 14,
            ),
          ],
        ),
        SizedBox(
          width: 160, // مهم عشان الـ Row
          child: DropdownButtonFormField<String>(
            hint: IntroSecondText(
              subtitle: "اختر الدور",
              color:dark,
              size: 14,
            ),
            dropdownColor:light,

            value: selectedRole,
            items: [
              DropdownMenuItem(
                value: "زوجة",
                child: IntroSecondText(
                  subtitle: "زوجة",
                  color: dark,
                  size: 14,
                ),
              ),
              DropdownMenuItem(
                value: "زوج",
                child: IntroSecondText(
                  subtitle: "زوج",
                  color:dark,
                  size: 14,
                ),
              ),
              DropdownMenuItem(
                value: "ضيف",
                child: IntroSecondText(
                  subtitle: "ضيف",
                  color:dark,
                  size: 14,
                ),
              ),
            ],
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ],
    ),
  );
}
Widget SearchBarByUser({
  required BuildContext context,
  required Function(String) onChanged,
}) {
  final w = MediaQuery.of(context).size.width;
  final h = MediaQuery.of(context).size.height;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: w * (330 / 375),
        height: h * (50 / 812),
        padding: EdgeInsets.symmetric(horizontal: w * (10 / 375)),
        decoration: BoxDecoration(
          color:light,
          borderRadius: BorderRadius.circular(w * (4 / 375)),
          border: Border.all(color:Colors.grey[400]!, width: 1), // بوردير أسود
        ),
        child: Row(
          textDirection: TextDirection.rtl, // الأيقونة على اليمين
          children: [
            Icon(
              Icons.search,
              color: Colors.grey[400], // أيقونة سوداء
              size: w * (20 / 375),
            ),
            SizedBox(width: w * (8 / 375)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  onChanged: onChanged,
                  style: TextStyle(
                    fontSize: w * (16 / 375),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BahijTheSansArabic',
                  ),
                  decoration: InputDecoration(
                    hintText: 'أدخل اسم المستخدم',
                    hintStyle: TextStyle(
                      fontSize: w * (14 / 375),
                      color: Colors.grey[400],
                      fontFamily: 'BahijTheSansArabic',
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


Widget EventInformationCard({
  required String image,
  required String main,
  required String info,
  required BuildContext context,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  return Column(
    children: [
      Container(
        // في الروتيت (Landscape) العرض يكون 50% من الشاشة لكي لا يمتد بشكل مبالغ فيه
        width: isLandscape ? screenWidth * 0.5 : screenWidth * 0.9,
        // تقليل الـ padding في وضع الروتيت لجعل الكارد "نحيفاً"
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: isLandscape ? 6 : 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            // الدائرة المحيطة بالصورة
            Container(
              // تصغير قطر الدائرة في وضع الروتيت
              width: isLandscape ? 40 : screenWidth * 0.12,
              height: isLandscape ? 40 : screenWidth * 0.12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // استبدليه بـ light
              ),
              child: Center(
                child: Image.asset(
                  image,
                  // الصورة تبقى دائماً أصغر من الدائرة بنسبة ثابتة
                  width: isLandscape ? 20 : (screenWidth * 0.12) * 0.5,
                  height: isLandscape ? 20 : (screenWidth * 0.12) * 0.5,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    main,
                    style: TextStyle(
                      color: Colors.black, // استبدليه بـ dark
                      fontWeight: FontWeight.bold,
                      // تصغير الخط قليلاً في الروتيت ليتناسب مع الحجم الجديد
                      fontSize: isLandscape ? 14 : screenWidth * 0.04,
                    ),
                  ),
                  Text(
                    info,
                    style: TextStyle(
                      color: Colors.black54, // استبدليه بـ dark
                      fontSize: isLandscape ? 12 : screenWidth * 0.032,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
    ],
  );
}

Container bottomBarEventDetails(BuildContext context, {required String title,required VoidCallback onPressed,}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
      width: double.infinity,
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: screenWidth * 0.03, // بدل 12
            offset: Offset(0, screenWidth * 0.015), // بدل 6
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,
        right:8.0),
        child: Align(
         alignment: Alignment.center,
          child: BigIntroButton(title:title,
              onPressed:onPressed

        ),
      ),
    ),
  );
}