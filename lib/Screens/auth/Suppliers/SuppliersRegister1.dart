import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../Shared/Components/Cards.dart';
import '../../../Shared/Components/buttons.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';
import 'SuppliersRegister2.dart';

class SuppliersRegister extends StatefulWidget {
  const SuppliersRegister({super.key});

  @override
  State<SuppliersRegister> createState() => _SuppliersRegisterState();
}

String selectedCode = '+963'; // كود افتراضي
TextEditingController phoneController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController nameController = TextEditingController();
final PageController _pageController = PageController();


final List<String> countryCodes = [
  '+963', // سوريا
  '+966', // السعودية
  '+971', // الإمارات
  '+20',  // مصر
  '+962', // الأردن
];

class _SuppliersRegisterState extends State<SuppliersRegister> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainCard(
              title: 'إنشاء حساب جديد',
              subtitle: 'أنشى حسابك وقدم خدماتك بسهولة',
              context: context, onPressed: () {
              Get.to(SuppliersRegister2());
            }, isLastScreen:false,
            ),

            SizedBox(height: height * 0.02), // بدل 30

            Padding(
              padding: EdgeInsets.all(width * 0.025), // بدل 10
              child: Column(
                children: [
                  ///////////name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      LabelText(label: "الاسم"
                          " الكامل"),
                    ],
                  ),
                  SizedBox(height: height * 0.007), // بدل 5
                  InputField(hint: 'أدخل الاسم', controller:nameController, keyboradType:TextInputType.text ),
                  SizedBox(height: height * 0.04), // بدل 30
                  ///////phone number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      LabelText(label: "رقم الهاتف "),
                    ],
                  ),
                  SizedBox(height: height * 0.007), // بدل 5
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'BahijTheSansArabic',
                          ),
                          decoration: InputDecoration(
                            hintText:"أدخل رقم الهاتف",
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: const TextStyle(
                              fontFamily: 'BahijTheSansArabic',
                              color:lightDark,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.012), // بدل 5
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: selectedCode,
                              isExpanded: true, // مهم
                              items: countryCodes.map((code) {
                                return DropdownMenuItem(
                                  value: code,
                                  child: Text(code),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCode = value!;
                                });
                              },
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'BahijTheSansArabic',
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: lightDark,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.04), // بدل 30
                  ////////////password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      LabelText(label: 'كلمة المرور'),
                    ],
                  ),
                  SizedBox(height: height * 0.007), // بدل 5
                  InputField(
                    hint: 'أدخل كلمة المرور',
                    controller: passController,
                    keyboradType: TextInputType.visiblePassword,
                    icon: const Icon(Icons.remove_red_eye_outlined),
                  ),
                  SizedBox(height: height * 0.04), // بدل 30
                  ///////password confirm
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      LabelText(label: 'تأكيد كلمة المرور'),
                    ],
                  ),
                  SizedBox(height: height * 0.007), // بدل 5
                  InputField(
                    hint: 'أدخل تأكيد كلمة المرور',
                    controller: passController,
                    keyboradType: TextInputType.visiblePassword,
                    icon: const Icon(Icons.remove_red_eye_outlined),
                  ),
                  SizedBox(height: height * 0.040), // بدل 5
                  IntroButton(title:"السابق",
                  onPressed:(){
                    Get.back();
                  })

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
