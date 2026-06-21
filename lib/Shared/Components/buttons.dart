
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/Colors.dart';
import 'components.dart';

Widget IntroButton({required String title, VoidCallback? onPressed}) {
  return Container(
    width: double.infinity,
    height: 35,
    child: ElevatedButton(
      onPressed: onPressed ?? () {}, // إذا ما حددتي onPressed ما يحصل خطأ
      style: ElevatedButton.styleFrom(
        backgroundColor: purple, // لون الزر
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'BahijTheSansArabic', // الخط المخصص
        ),
      ),
    ),
  );
}
Widget BigIntroButton({required String title, VoidCallback? onPressed}) {
  return Container(
    width: double.infinity,
    height: 45,
    child: ElevatedButton(
      onPressed: onPressed ?? () {}, // إذا ما حددتي onPressed ما يحصل خطأ
      style: ElevatedButton.styleFrom(
        backgroundColor: purple, // لون الزر
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'BahijTheSansArabic', // الخط المخصص
        ),
      ),
    ),
  );
}
Widget BlackBigIntroButton({required String title, VoidCallback? onPressed}) {
  return Container(
    width: double.infinity,
    height: 45,
    child: ElevatedButton(
      onPressed: onPressed ?? () {}, // إذا ما حددتي onPressed ما يحصل خطأ
      style: ElevatedButton.styleFrom(
        backgroundColor:dark, // لون الزر
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'BahijTheSansArabic', // الخط المخصص
        ),
      ),
    ),
  );
}
Widget SmallIntroButton({required String title, VoidCallback? onPressed}) {
  return Container(
    width: double.infinity,
    height:25,
    child: ElevatedButton(
      onPressed: onPressed ?? () {}, // إذا ما حددتي onPressed ما يحصل خطأ
      style: ElevatedButton.styleFrom(
        backgroundColor: purple, // لون الزر
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'BahijTheSansArabic', // الخط المخصص
        ),
      ),
    ),
  );
}



Widget IntroTextButton({VoidCallback? onPressed,required String title,required double size}) {
  return TextButton(
    onPressed: onPressed ?? () {},
    style: TextButton.styleFrom(
      foregroundColor: purple,
      textStyle: TextStyle(
        fontSize: size,
        decoration: TextDecoration.underline, // الخط تحت
        fontFamily: 'BahijTheSansArabic',
      ),
    ),
    child: Text(
      title,
      style: TextStyle(fontFamily: 'BahijTheSansArabic'),
    ),
  );
}
Widget IntroButtonOutlined({required String title, VoidCallback? onPressed}) {
  return Container(
    width: double.infinity,
    height: 35,
    child: OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: purple, width: 2), // لون الحدود وسمكها
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: purple, // لون النص مطابق للحد
          fontSize: 16,
          fontFamily: 'BahijTheSansArabic',
        ),
      ),
    ),
  );
}
bool isChecked = false;

Widget SmallCheckbox({
  required bool value,
  required ValueChanged<bool?> onChanged,
}) {
  return Transform.scale(
    scale: 0.9, // 🔹 صغّر الحجم (غيّرها حسب ما بدك)
    child: Checkbox(
      activeColor:purple ,
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side:BorderSide(
              color:purple,
          )// 🔹 مربع تقريباً
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact, // 🔹 يقلل المساحة
    ),
  );
}

Widget allStickerButton({VoidCallback? onPressed}){
  return Container(
      width:85,
      height:30,
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical:3), // 👈 إبعاد النص
      decoration: BoxDecoration(
        color:purple,
        borderRadius: BorderRadius.circular(8
        ),
      ),
      child:InkWell(child: IntroSecondText(subtitle:'< عرض الكل', color: light, size:14),
      onTap:onPressed,)
  );
}
