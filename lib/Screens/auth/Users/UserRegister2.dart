import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../Controllers/authController.dart';
import '../../../Shared/Components/Cards.dart';
import '../../../Shared/Components/buttons.dart';
import '../../../Shared/Components/components.dart';
import '../LogIn.dart';
import '../OtpScreen.dart';

class Userregister2 extends StatelessWidget {
  const Userregister2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double w = constraints.maxWidth;
          final double h = constraints.maxHeight;
          final bool isLandscape = w > h;

          return SingleChildScrollView(
            child: Column(
              children: [
                MainCard(
                  title: 'إنشاء حساب جديد',
                  subtitle: 'أنشى حسابك وقدم خدماتك بسهولة',
                  context: context,
                  onPressed: () => Get.back(),
                  isLastScreen: false,
                ),
                SizedBox(height: h * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? w * 0.2 : w * 0.025,
                  ),
                  child: Column(
                    children: [
                      Align(alignment: Alignment.topRight, child: LabelText(label: "اسم المستخدم")),
                      SizedBox(height: h * 0.007),
                      InputField(hint: 'أدخل اسم المستخدم خاصتك', controller: controller.userNameController, keyboradType: TextInputType.text),

                      SizedBox(height: h * 0.04),
                      Align(alignment: Alignment.topRight, child: LabelText(label: "الجنس")),
                      SizedBox(height: h * 0.007),
                      Obx(() => GenderDropdown(
                          value: controller.selectedGender.value,
                          onChanged: (val) => controller.selectedGender.value = val!
                      )),

                      SizedBox(height: h * 0.04),
                      Align(alignment: Alignment.topRight, child: LabelText(label: "تاريخ الميلاد")),
                      SizedBox(height: h * 0.007),
                      // حقل التاريخ مع التقويم
                      GestureDetector(
                        onTap: () => _selectDate(context, controller),
                        child: AbsorbPointer(
                          child: InputField(
                              hint: 'أدخل تاريخ عيد الميلاد خاصتك',
                              controller: controller.birthdayController,
                              keyboradType: TextInputType.datetime
                          ),
                        ),
                      ),

                      SizedBox(height: h * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IntroTextButton(title: 'أوافق على الشروط والأحكام', size: 14),
                          Obx(() => SmallCheckbox(
                              value: controller.isAccepted.value,
                              onChanged: (val) => controller.isAccepted.value = val!
                          )),
                        ],
                      ),

                      SizedBox(height: h * 0.013),
                      Obx(() => controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : BigIntroButton(
                        title: 'إرسال رمز التحقق', // تغيير العنوان ليكون أدق
                        onPressed: () {
                          // 1. نطلب الرمز أولاً بناءً على الإيميل المدخل
                          controller.sendOtpCode(controller.emailController.text).then((_) {
                            // 2. ننتقل لصفحة الـ OTP (يفضل التأكد من نجاح الإرسال داخل الكنترولر)
                            Get.to(() => const Otpscreen());
                          });
                        },
                      )),// ...
                      SizedBox(height: h * 0.013),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IntroTextButton(
                            title: "تسجيل الدخول",
                            size: 16,
                            onPressed: () => Get.to(Login()),
                          ),
                          LabelText(label: "هل لديك حساب؟"),
                        ],
                      ),
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

  // دالة التقويم بنفس ثيم وخط التطبيق
  Future<void> _selectDate(BuildContext context, RegisterController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.purple, // لون تطبيقك
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontFamily: 'BahijTheSansArabic'),
              ),
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      controller.birthdayController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }
}