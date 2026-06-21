import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Shared/Components/Cards.dart';
import '../../../Shared/Components/buttons.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';

class SuppliersRegister3 extends StatefulWidget {
  const SuppliersRegister3({super.key});

  @override
  State<SuppliersRegister3> createState() => _SuppliersRegister3State();
}

TextEditingController AdressController = TextEditingController();
TextEditingController WebsiteController = TextEditingController();
TextEditingController FacebookController = TextEditingController();
TextEditingController InstagramController = TextEditingController();
File? _image;
final ImagePicker _picker = ImagePicker();





class _SuppliersRegister3State extends State<SuppliersRegister3> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    Future<void> pickImage() async {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainCard(
              title: 'إنشاء حساب جديد',
              subtitle: 'أنشى حسابك وقدم خدماتك بسهولة',
              context: context, onPressed: () {  }, isLastScreen:true,

            ),

            SizedBox(height: height * 0.02), // بدل 30

            Padding(
              padding: EdgeInsets.only(
                left:width * 0.025,
                right:width * 0.025,
                top:width * 0.025,
                bottom:width * 0.075
              ), // بدل 10
              child: Column(
                children: [
                  ///////////name
                  Align(alignment:Alignment.topRight,child: LabelText(label: "حساب الواتساب"),
                  ),
                  SizedBox(height: height * 0.007), // بدل 5
                  InputField(hint: 'أدخل رابط حساب الواتساب', controller:AdressController, keyboradType:TextInputType.text ),
                  SizedBox(height: height * 0.04), // بدل 30
                  ///////phone number
                  Align(
                      alignment:Alignment.topRight,
                      child: LabelText(label: " حساب X")),
                  SizedBox(height: height * 0.007),
                  InputField(hint: 'أدخل رابط حساب X خاصتك', controller:WebsiteController, keyboradType:TextInputType.text ), // بدل 5
                  SizedBox(height: height * 0.04), // بدل 30
                  ////////////password
                  Align(alignment:Alignment.topRight,child: LabelText(label: 'حساب تيليغرام'),
                  ),
                  SizedBox(height: height * 0.007), // بدل 5
                  InputField(hint: 'أدخل رابط حساب تيليغرام خاصتك', controller:WebsiteController, keyboradType:TextInputType.text ), // بدل 5
                  SizedBox(height: height * 0.04), // بدل 30
                  ///////password confirm
                  Align(
                      alignment:Alignment.topRight,
                      child: LabelText(label: 'شعار الخدمة أو الشركة')),
                  SizedBox(height: height * 0.015), // بدل 5
                  _image != null
                      ? Image.file(_image!, width: 200)
                      : Align(
                    alignment:Alignment.center,
                      child: IntroSecondText(subtitle:'لم يتم اختيار صورة', color:dark, size:14)),
                  SizedBox(height: height * 0.005), // بدل 5
                  IntroTextButton(title:"تعديل", size:16,
                      onPressed:(){
                        pickImage();
                      }),
                  SizedBox(height: height * 0.030), // بدل 5
                  BigIntroButton(title:"إنشاء حساب",
                      onPressed:(){
                      }),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
