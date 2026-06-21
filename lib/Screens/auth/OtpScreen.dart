import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Controllers/authController.dart';
import '../../Shared/Components/Cards.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import 'LogIn.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({super.key});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final controller = Get.put(RegisterController());

  final List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  int minutes = 2;
  int seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.serverOtpCode.value.isEmpty) {
        controller.sendOtpCode(controller.emailController.text);
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // جلب الأبعاد كنسب مئوية من قياس الشاشة المتاح
          final double w = constraints.maxWidth;
          final double h = constraints.maxHeight;
          final bool isLandscape = w > h;

          return SingleChildScrollView(
            child: Column(
              children: [
                // الكارد العلوي
                MainCard(
                  context: context,
                  title: "تأكيد الحساب",
                  // هنا نستخدم الدالة لتشفير الإيميل قبل عرضه
                  subtitle: "لقد أرسلنا رمز تحقق إلى البريد:\n     ${controller.maskEmail("ledadayoub8@gmail.com")}",
                  onPressed: () => Get.back(),
                  isLastScreen: false,
                ),
                // مسافة متغيرة بناءً على الارتفاع 5%
                SizedBox(height: h * 0.05),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? w * 0.2 : w * 0.05,
                  ),
                  child: Column(
                    children: [
                      // حقول الـ OTP
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.01), // مسافة 1% بين الحقول
                              child: _otpField(index: index, screenWidth: w, screenHeight: h),
                            );
                          }),
                        ),
                      ),

                      SizedBox(height: h * 0.04), // مسافة 4%

                      // عداد الوقت
                      Text(
                        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isLandscape ? h * 0.06 : w * 0.05, // حجم خط مرن
                            color: Colors.purple
                        ),
                      ),

                      SizedBox(height: h * 0.02),

                      // إعادة الإرسال
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IntroTextButton(
                            title: "إعادة الإرسال",
                            size: isLandscape ? 14 : 16,
                            onPressed: (minutes == 0 && seconds == 0) ? _resendCode : null,
                          ),
                          LabelText(label: "لم يصلك الرمز؟"),
                        ],
                      ),

                      SizedBox(height: h * 0.05),

                      // زر التأكيد
                      Obx(() => controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.purple)
                          : SizedBox(
                        width: isLandscape ? w * 0.4 : w * 0.9, // عرض الزر 40% في العرضي و 90% في الطولي
                        child: BigIntroButton(
                          title: 'تأكيد وإنشاء الحساب',
                          onPressed: () => _handleVerify(),
                        ),
                      )),

                      SizedBox(height: h * 0.05),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // دالة المعالجة عند الضغط
  void _handleVerify() {
    String fullCode = controllers.map((e) => e.text).join();
    if (fullCode.length < 6) {
      Get.snackbar("تنبيه", "يرجى إكمال رمز التحقق", backgroundColor: Colors.amberAccent);
    } else {
      if (fullCode == controller.serverOtpCode.value) {
        controller.signup().then((isSuccess) {
          if (isSuccess) {
            Get.offAll(() => const Login());
            Get.snackbar("نجاح", "تم إنشاء حسابك بنجاح");
          }
        });
      } else {
        Get.snackbar("خطأ", "رمز التحقق غير صحيح", backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    }
  }

  Widget _otpField({required int index, required double screenWidth, required double screenHeight}) {
    // جعل عرض الحقل 12% من عرض الشاشة في الوضع الطولي، وأصغر في العرضي
    double fieldWidth = screenWidth > screenHeight ? screenWidth * 0.08 : screenWidth * 0.12;

    return SizedBox(
      width: fieldWidth,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controllers[index].text.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
        child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(
              fontSize: screenHeight * 0.03, // حجم نص مرن بناءً على الارتفاع
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // حشوة داخلية مرنة
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(screenWidth * 0.02), // انحناء مرن
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
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
      ),
    );
  }
}
