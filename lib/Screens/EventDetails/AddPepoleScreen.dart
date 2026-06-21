import 'package:flutter/material.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/EventDetails/SearchBarByUser.dart';
import '../../Shared/Components/EventDetails/dashedCircle.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class Addpepolescreen extends StatefulWidget {
  const Addpepolescreen({super.key});

  @override
  State<Addpepolescreen> createState() => _AddpepolescreenState();
}

class _AddpepolescreenState extends State<Addpepolescreen> {
  TextEditingController userNameController = TextEditingController();
  bool isClickable = false;
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    // جلب أبعاد الشاشة الحالية لتحديثها عند التدوير
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double baseUnit = mediaQuery.size.shortestSide;

    return Scaffold(
      backgroundColor: Colors.white,
      // SingleChildScrollView هو الحل الأساسي لمنع الـ Overflow
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03, // 3% من عرض الشاشة
            vertical: screenHeight * 0.02, // 2% من طول الشاشة
          ),
          child: Column(
            children: [
              InkWell(
                child: Row(
                  children: [
                    DashedCircleWidget(
                      size: baseUnit * 0.13, // حجم الدائرة متناسب مع حجم الشاشة
                      color: purple,
                      strokeWidth: 2,
                      dashWidth: 10,
                      dashSpace: 6,
                      child: Icon(
                        Icons.people_outline,
                        color: purple,
                        size: baseUnit * 0.065,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    IntroSecondText(
                      subtitle: "ابحث باستخدام اسم المستخدم",
                      color: dark,
                      size: baseUnit * 0.04,
                    )
                  ],
                ),
                onTap: () {
                  setState(() {
                    isClickable = !isClickable;
                  });
                },
              ),

              SizedBox(height: screenHeight * 0.02),

              if (isClickable)
                Column(
                  children: [
                    SearchBarByUser(context: context, onChanged: (String p1) {}),
                    SizedBox(height: screenHeight * 0.01),
                    Align(
                      alignment: Alignment.topRight,
                      child: IntroSecondText(
                        subtitle: "يجب أن يكون اسم المستخدم موجوداً في التطبيق ",
                        color: dark,
                        size: baseUnit * 0.03,
                      ),
                    ),
                  ],
                ),

              SizedBox(height: screenHeight * 0.03),

              // الـ Card الخاص بإضافة الأشخاص
              AddPeopleCard(
                selectedRole: selectedRole,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
              ),

              // مساحة إضافية في الأسفل لضمان راحة التمرير عند ظهور لوحة المفاتيح
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}