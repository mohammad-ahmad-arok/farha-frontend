import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/components.dart';

class Socialinfo extends StatefulWidget {
  const Socialinfo({super.key});

  @override
  State<Socialinfo> createState() => _SocialinfoState();
}

TextEditingController facebookController = TextEditingController();
TextEditingController instagramController = TextEditingController();
TextEditingController websiteController = TextEditingController();
TextEditingController teleController = TextEditingController();
TextEditingController whatsupController = TextEditingController();

class _SocialinfoState extends State<Socialinfo> {
  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // هوامش متجاوبة (5% من العرض للهوامش الأفقية)
    final horizontalPadding = screenWidth * 0.01;
    // مسافات عمودية متناسبة (2% من الارتفاع)
    final verticalSpacing = screenHeight * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'رابط الموقع الإلكتروني'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'www.user.com',
                controller: websiteController,
                keyboradType: TextInputType.text,
                obscureText: false,
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'رابط الفيسبوك'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'www.facebook.com/youraccount',
                controller: facebookController,
                keyboradType: TextInputType.text,
                obscureText: false,
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'رابط الإنستغرام'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'www.instagram.com/user',
                controller: instagramController,
                keyboradType: TextInputType.text,
                obscureText: false,
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'رابط الوتساب'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'www.whatsapp.com/user',
                controller: whatsupController,
                keyboradType: TextInputType.text,
                obscureText: false,
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'رابط التيليجرام'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'www.Telegram.com/user',
                controller: teleController,
                keyboradType: TextInputType.text,
                obscureText: false,
              ),
              SizedBox(height: verticalSpacing * 2), // مسافة إضافية في الأسفل
            ],
          ),
        ),
      ),
    );
  }
}