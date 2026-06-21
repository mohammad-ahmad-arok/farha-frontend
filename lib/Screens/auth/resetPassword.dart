import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Controllers/authController.dart'; // تأكدي من المسار الصحيح
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  // 1. تعريف الكنترولر (تأكدي من استخدام الكنترولر المناسب لعملية الـ Reset)
  final controller = Get.put(RegisterController());

  // 2. تعريف متغيرات الـ OTP والـ Timer
  final List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  int minutes = 2;
  int seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else if (minutes > 0) {
          minutes--;
          seconds = 59;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resendCode() {
    if (minutes == 0 && seconds == 0) {
      setState(() { minutes = 2; seconds = 0; });
      _startTimer();
      // استدعاء دالة إعادة الإرسال من الكنترولر
      controller.sendOtpCode(controller.emailController.text);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var node in focusNodes) node.dispose();
    for (var c in controllers) c.dispose();
    super.dispose();
  }

  void _handleVerify() {
    String fullCode = controllers.map((e) => e.text).join();
    if (fullCode.length < 6) {
      Get.snackbar("تنبيه", "يرجى إكمال رمز التحقق", backgroundColor: Colors.amberAccent);
    } else {
      // منطق التحقق الخاص بكِ هنا
      print("Verifying code: $fullCode");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double w = constraints.maxWidth;
            final double h = constraints.maxHeight;
            final bool isLandscape = w > h;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Column(
                children: [
                  SizedBox(height: h * 0.05),

                  /// التصميم الجديد البديل للكارد
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        // الحفاظ على الخلفية البنفسجية الخفيفة لتعطي جمالية للصورة
                        color: purple.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/OTP.png", // تأكدي من امتداد الملف (png أو webp) ومن مساره في الـ pubspec.yaml
                        width: isLandscape ? h * 0.20 : w * 0.30, // تكبير الحجم قليلاً لأن الصور تحتاج مساحة أوضح من الأيقونات
                        height: isLandscape ? h * 0.20 : w * 0.30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),

                  Text(
                    "إعادة تعيين كلمة المرور",
                    style: TextStyle(
                      fontSize: isLandscape ? h * 0.07 : w * 0.06,
                      fontWeight: FontWeight.bold,
                      color: dark,
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: isLandscape ? h * 0.04 : w * 0.038,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: "لقد أرسلنا رمز التحقق إلى البريد الإلكتروني\n",
                          style: const TextStyle(fontFamily: 'BahijTheSansArabic'),
                        ),
                        TextSpan(
                          text: controller.maskEmail(controller.emailController.text),
                          style: TextStyle(
                            color: purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.06),

                  /// حقول الـ OTP
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.012),
                          child: _otpField(index: index, screenWidth: w, screenHeight: h),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: h * 0.05),

                  /// العداد وإعادة الإرسال
                  Column(
                    children: [
                      Text(
                        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isLandscape ? h * 0.06 : w * 0.05,
                            color: purple
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // تأكدي من استيراد الملف الذي يحتوي على IntroTextButton
                          TextButton(
                            onPressed: (minutes == 0 && seconds == 0) ? _resendCode : null,
                            child: Text(
                              "إعادة الإرسال",
                              style: TextStyle(
                                color: (minutes == 0 && seconds == 0) ? purple : Colors.grey,
                                fontSize: isLandscape ? 14 : 16,
                              ),
                            ),
                          ),
                          const Text("لم يصلك الرمز؟", style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.06),

                  /// زر التأكيد
                  Obx(() => controller.isLoading.value
                      ? CircularProgressIndicator(color: purple)
                      : SizedBox(
                    width: isLandscape ? w * 0.4 : w * 0.9,
                    child: BigIntroButton(
                      title: 'تأكيد الرمز',
                      onPressed: () => _handleVerify(),
                    ),
                  )),

                  SizedBox(height: h * 0.05),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // دالة حقل الـ OTP (كانت مفقودة في ملفك)
  Widget _otpField({required int index, required double screenWidth, required double screenHeight}) {
    double fieldWidth = screenWidth > screenHeight ? screenWidth * 0.08 : screenWidth * 0.12;

    return SizedBox(
      width: fieldWidth,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(
            fontSize: screenHeight * 0.03,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: purple, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}