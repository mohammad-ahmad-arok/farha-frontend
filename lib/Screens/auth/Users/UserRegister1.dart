import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../Controllers/authController.dart';
import '../../../Shared/Components/Cards.dart';
import '../../../Shared/Components/buttons.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';
import '../../intro/intro4.dart';
import 'UserRegister2.dart';

class UserRegister1 extends StatelessWidget {
  const UserRegister1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

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
                  subtitle: 'أنشى حسابك ونظم مناسبتك بسهولة',
                  context: context,
                  onPressed: () => Get.to(() => const Intro4()),
                  isLastScreen: false,
                ),
                SizedBox(height: h * 0.02), // نفس قيمتك 0.02
                Padding(
                  // الحفاظ على 0.025 للعرض، مع زيادة الهامش في Landscape فقط للتوازن
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? w * 0.2 : w * 0.025,
                  ),
                  child: Column(
                    children: [
                      _buildField("الاسم الأول", "أدخل الأول", controller.firstNameController, h),
                      _buildField("الاسم الأخير", "أدخل الأخير", controller.lastNameController, h),
                      _buildField("البريد الإلكتروني", "أدخل البريد الإلكتروني", controller.emailController, h),

                      Align(alignment: Alignment.topRight, child: LabelText(label: "رقم الهاتف")),
                      SizedBox(height: h * 0.007),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: "أدخل رقم الهاتف",
                                hintStyle: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: 16),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.012), // قيمتك 0.012
                          Expanded(
                            flex: 2,
                            child: _buildCountryDropdown(controller),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.04),

                      _buildPasswordField("كلمة المرور", controller.passController, controller.isPasswordHidden, controller, h),
                      _buildPasswordField("تأكيد كلمة المرور", controller.confirmPassController, controller.isConfirmPasswordHidden, controller, h),

                      SizedBox(height: h * 0.04),
                      IntroButton(
                          title: "التالي",
                          onPressed: () {
                            if (controller.validateFirstStep()) {
                              Get.to(() => const Userregister2());
                            }
                          }
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

  // ميثود للحفاظ على المسافات (0.007 و 0.04) التي اخترتِها
  Widget _buildField(String label, String hint, TextEditingController textController, double h) {
    return Column(
      children: [
        Align(alignment: Alignment.topRight, child: LabelText(label: label)),
        SizedBox(height: h * 0.007),
        InputField(hint: hint, controller: textController, keyboradType: TextInputType.text),
        SizedBox(height: h * 0.04),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController textController, RxBool isHidden, var controller, double h) {
    return Column(
      children: [
        Align(alignment: Alignment.topRight, child: LabelText(label: label)),
        SizedBox(height: h * 0.007),
        Obx(() => InputField(
          hint: 'أدخل $label',
          controller: textController,
          keyboradType: TextInputType.visiblePassword,
          isPassword: true,
          obscureText: isHidden.value,
          onIconTap: () => isHidden.value = !isHidden.value,
        )),
        SizedBox(height: h * 0.04),
      ],
    );
  }

  Widget _buildCountryDropdown(var controller) {
    return Obx(() => DropdownButtonFormField<String>(
      value: controller.selectedCountryCode.value,
      isExpanded: true,
      items: ['+963', '+966', '+971', '+20', '+962'].map((code) => DropdownMenuItem(value: code, child: Text(code))).toList(),
      onChanged: (value) => controller.selectedCountryCode.value = value!,
      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    ));
  }
}