import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../Shared/Components/Cards.dart';
import '../../../Shared/Components/buttons.dart';
import '../../../Shared/Components/components.dart';
import 'SuppliersRegister3.dart';

class SuppliersRegister2 extends StatefulWidget {
  const SuppliersRegister2({super.key});

  @override
  State<SuppliersRegister2> createState() => _SuppliersRegister2State();
}

TextEditingController AdressController = TextEditingController();
TextEditingController WebsiteController = TextEditingController();
TextEditingController FacebookController = TextEditingController();
TextEditingController InstagramController = TextEditingController();
final PageController _pageController = PageController();




class _SuppliersRegister2State extends State<SuppliersRegister2> {
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
              Get.to(SuppliersRegister3());

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
                      LabelText(label: "العنوان"),
                    ],
                  ),
                  SizedBox(height: height * 0.007), // بدل 5
                  InputField(hint: 'أدخل العنوان', controller:AdressController, keyboradType:TextInputType.text ),
                  SizedBox(height: height * 0.04), // بدل 30
                  ///////phone number
                  Align(
                    alignment:Alignment.topRight,
                      child: LabelText(label: "موقع الويب الخاص بك")),
                  SizedBox(height: height * 0.007),
                  InputField(hint: 'أدخل رابط موقع الويب خاصتك', controller:WebsiteController, keyboradType:TextInputType.text ), // بدل 5
                  SizedBox(height: height * 0.04), // بدل 30
                  ////////////password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      LabelText(label: 'حساب الفيسبوك'),
                    ],
                  ),
                  SizedBox(height: height * 0.007), // بدل 5
                  InputField(hint: 'أدخل رابط حساب الفيسبوك خاصتك', controller:WebsiteController, keyboradType:TextInputType.text ), // بدل 5
                  SizedBox(height: height * 0.04), // بدل 30
                  ///////password confirm
                  Align(
                      alignment:Alignment.topRight,
                      child: LabelText(label: 'حساب الإنستغرام')),
                  SizedBox(height: height * 0.007), // بدل 5
                  InputField(hint: 'أدخل رابط حساب الإنستغرام خاصتك', controller:WebsiteController, keyboradType:TextInputType.text ), // بدل 5
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
