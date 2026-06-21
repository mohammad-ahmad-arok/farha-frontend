import 'dart:async';
import 'package:final_farha_pro/Screens/intro/start.dart';
// استورد الصفحة الرئيسية هنا، لنفرض اسمها HomeScreen
// import 'package:farha_pproject/Screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/Style/Colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  // دالة التحكم بالتنقل
  _navigateToNext() async {
    // ننتظر 3 ثواني أولاً (مدة ظهور اللوغو)
    await Future.delayed(const Duration(seconds: 3));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // إذا كانت القيمة null يعني أول مرة يفتح التطبيق
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // إذا أول مرة، نحفظ أنه دخل ومن ثم نتوجه لصفحة البداية
      await prefs.setBool('isFirstTime', false);
      Get.offAll(() => const Start()); // استخدام offAll لغلق صفحة السبلاش تماماً
    } else {
      // إذا مو أول مرة، نتوجه مباشرة للرئيسية (استبدل HomeScreen بصفحتك)
      // Get.offAll(() => const HomeScreen());
      Get.offAll(() => const Start()); // مؤقتاً سأتركها تذهب لـ Start حتى تحدد صفحتك الرئيسية
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // يفضل تحديد لون الخلفية
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/intro4.png",
              width: 180,
            ),
            const Spacer(),
            const CircularProgressIndicator(
              color: purple,
              strokeWidth: 3,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}