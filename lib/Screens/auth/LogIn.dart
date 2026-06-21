import 'package:final_farha_pro/Screens/auth/resetPassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Controllers/authController.dart';
import '../../Shared/Components/Cards.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import '../Profile/Profile.dart';
import '../home-layout/Home-layout.dart';
import 'Users/UserRegister1.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

String selectedCode = '+963'; // كود افتراضي

final List<String> countryCodes = [
  '+963', // سوريا
  '+966', // السعودية
  '+971', // الإمارات
  '+20',  // مصر
  '+962', // الأردن
];

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;
          final bool isLandscape = width > height;

          return SingleChildScrollView(
            child: Column(
              children: [
                MainCard(
                  title: 'أهلا بعودتك إلى فرحة',
                  subtitle: 'سجل دخولك لإدارة مناسباتك بكل سهولة',
                  context: context,
                  onPressed: () { Get.back(); },
                  isLastScreen: false,
                ),

                SizedBox(height: height * 0.04),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isLandscape ? width * 0.2 : width * 0.025),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: LabelText(label: "البريد الإلكتروني"),
                      ),
                      SizedBox(height: height * 0.007),
                      InputField(
                        hint: 'أدخل البريد الإلكتروني',
                        controller: controller.emailController,
                        keyboradType: TextInputType.text,
                      ),

                      SizedBox(height: height * 0.04),

                      Align(
                        alignment: Alignment.topRight,
                        child: LabelText(label: 'كلمة المرور'),
                      ),
                      SizedBox(height: height * 0.007),

                      Obx(() => InputField(
                        hint: 'أدخل كلمة المرور',
                        controller: controller.passController,
                        keyboradType: TextInputType.visiblePassword,
                        isPassword: true,
                        obscureText: controller.isPasswordHidden.value,
                        onIconTap: () {
                          controller.isPasswordHidden.value = !controller.isPasswordHidden.value;
                        },
                      )),
                      SizedBox(height: height * 0.007),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IntroTextButton(title: 'نسيت كلمة المرور؟', size: 16,
                          onPressed:(){
                            Get.to(Resetpassword());
                          }),
                          Row(
                            children: [
                              IntroTextButton(title: 'تذكرني', size: 16),
                              Obx(() => SmallCheckbox(
                                value: controller.isRememberMe.value,
                                onChanged: (bool? value) {
                                  controller.isRememberMe.value = value ?? false;
                                },
                              )),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.065),

                      Obx(() => controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.grey)
                          : BigIntroButton(
                        title: 'تسجيل الدخول',
                        onPressed: () {
                          controller.loginUser().then((success) {
                            if (success) {
                              Get.to(HomeLayout());
                            }
                          });
                        },
                      )),
                      SizedBox(height: height * 0.013),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LabelText(label: "ليس لديك حساب؟"),
                          IntroTextButton(
                            title: "إنشاء حساب",
                            size: 16,
                            onPressed: () { Get.to(UserRegister1()); },
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.04),
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
}