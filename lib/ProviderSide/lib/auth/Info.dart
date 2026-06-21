import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Shared/Style/Colors.dart';
import '../shared/components.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

// تعريف المتحكمات بشكل منفصل لكل حقل
TextEditingController arabicNameController = TextEditingController();
TextEditingController englishNameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

String selectedCode = '+963';
final List<String> countryCodes = [
  '+963', // سوريا
  '+966', // السعودية
  '+971', // الإمارات
  '+20',  // مصر
  '+962', // الأردن
];

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    // هوامش متجاوبة
    final horizontalPadding = screenWidth * 0.01; // 5% من عرض الشاشة
    final verticalSpacing = screenHeight * 0.02; // 2% من ارتفاع الشاشة

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
          child: Column(
            children: [
              AvatarWithEdit(),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'الاسم الكامل باللغة العربية'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'أدخل الاسم الكامل',
                controller: arabicNameController,
                keyboradType: TextInputType.text, obscureText: false,
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'الاسم الكامل باللغة الإنكليزية'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'EnName',
                controller: englishNameController,
                keyboradType: TextInputType.text, obscureText: false,
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: "رقم الهاتف"),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              // حقل رقم الهاتف مع كود الدولة
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3, // النسبة للكود
                    child: DropdownButtonFormField<String>(
                      value: selectedCode,
                      isExpanded: true,
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
                  ),
                  SizedBox(width: screenWidth * 0.02), // مسافة متجاوبة
                  Expanded(
                    flex: 7, // النسبة لرقم الهاتف
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
                        hintText: "أدخل رقم الهاتف",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: const TextStyle(
                          fontFamily: 'BahijTheSansArabic',
                          color: lightDark,
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
                ],
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'العنوان'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'أدخل العنوان بالتفصيل',
                controller: addressController,
                keyboradType: TextInputType.text, obscureText: false,
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'البريد الإلكتروني'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'user@gmail.com',
                controller: emailController,
                keyboradType: TextInputType.emailAddress, obscureText: false,
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'كلمة المرور'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'أدخل كلمة المرور',
                controller: passwordController,
                keyboradType: TextInputType.text,
                obscureText: true, // إضافة خاصية إخفاء النص
              ),
              SizedBox(height: verticalSpacing),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: 'تأكيد كلمة المرور'),
              ),
              SizedBox(height: verticalSpacing * 0.5),
              InputField(
                hint: 'أدخل كلمة المرور',
                controller: confirmPasswordController,
                keyboradType: TextInputType.text,
                obscureText: true,
              ),
              SizedBox(height: verticalSpacing * 2), // مسافة إضافية في الأسفل
            ],
          ),
        ),
      ),
    );
  }
}