import 'package:flutter/material.dart';
import '../../../Shared/Components/buttons.dart';
import '../../../Shared/Components/components.dart';
import '../Shared/Style/Colors.dart';

class Firsttime extends StatefulWidget {
  const Firsttime({super.key});

  @override
  State<Firsttime> createState() => _FirsttimeState();
}

class _FirsttimeState extends State<Firsttime> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery للحصول على أبعاد الشاشة
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white, // يفضل لون ثابت للخلفية بدلاً من الشفاف في الـ Scaffold
      body: SafeArea(
        child: Center( // لضمان التوسط في الشاشات الكبيرة (Tablets)
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: isLandscape ? screenWidth * 0.8 : screenWidth,
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, // 2% من ارتفاع الشاشة
                horizontal: screenWidth * 0.05, // 5% من عرض الشاشة
              ),
              child: Column(
                children: [
                  _buildHeader(isLandscape, screenHeight, screenWidth),

                  SizedBox(height: screenHeight * 0.04), // مسافة مرنة

                  Container(
                    constraints: BoxConstraints(
                      maxWidth: isLandscape ? screenWidth * 0.5 : double.infinity,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: screenWidth * 0.02,
                          offset: const Offset(0, 4),
                        )
                      ],
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAccountStatus(screenWidth, screenHeight),

                        SizedBox(height: screenHeight * 0.02),

                        // قائمة الخيارات مع أحجام نصوص مرنة
                        _buildCheckboxList(context, screenWidth),

                        SizedBox(height: screenHeight * 0.03),

                        // الأزرار مع هوامش مرنة
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                          child: BigIntroButton(title: "إكمال الإعدادات"),
                        ),

                        IntroTextButton(
                          title: "تخطي",
                          size: _getAdaptiveSize(screenWidth, 14),
                        ),

                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLandscape, double screenHeight, double screenWidth) {
    // حجم الصورة يعتمد على عرض الشاشة بنسبة مئوية
    final double imageSize = isLandscape ? screenHeight * 0.25 : screenWidth * 0.4;

    if (isLandscape) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/ifFirst.webp", width: imageSize, height: imageSize),
          SizedBox(width: screenWidth * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntroSecondText(subtitle: "إبدأ بإعداد حسابك لتظهر خدماتك للعملاء", color: dark, size: _getAdaptiveSize(screenWidth, 16)),
              IntroSecondText(subtitle: "وإبدأ باستقبال حجوزاتك", color: dark, size: _getAdaptiveSize(screenWidth, 16)),
            ],
          )
        ],
      );
    } else {
      return Column(
        children: [
          Image.asset("assets/ifFirst.webp", width: imageSize, height: imageSize),
          SizedBox(height: screenHeight * 0.02),
          IntroSecondText(subtitle: "إبدأ بإعداد حسابك لتظهر خدماتك للعملاء", color: dark, size: _getAdaptiveSize(screenWidth, 18)),
          IntroSecondText(subtitle: "وإبدأ باستقبال حجوزاتك", color: dark, size: _getAdaptiveSize(screenWidth, 18)),
        ],
      );
    }
  }

  Widget _buildAccountStatus(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.015
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1C4),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.03),
            topRight: Radius.circular(screenWidth * 0.03)
        ),
      ),
      child: Row(
        children: [
          IntroSecondText(subtitle: "حالة الحساب :", color: purple, size: _getAdaptiveSize(screenWidth, 14)),
          SizedBox(width: screenWidth * 0.02),
          IntroSecondText(subtitle: "نشط", color: purple, size: _getAdaptiveSize(screenWidth, 14)),
          const Spacer(), // يدفع الأيقونة للطرف الآخر
          Image.asset("assets/time.png", width: screenWidth * 0.05, height: screenWidth * 0.05),
        ],
      ),
    );
  }

  Widget _buildCheckboxList(BuildContext context, double screenWidth) {
    return Column(
      children: [
        buildCustomCheckbox("الخيار الأول", isChecked1, (val) => setState(() => isChecked1 = val!), screenWidth),
        buildCustomCheckbox("الخيار الثاني", isChecked2, (val) => setState(() => isChecked2 = val!), screenWidth),
        buildCustomCheckbox("الخيار الثالث", isChecked3, (val) => setState(() => isChecked3 = val!), screenWidth),
      ],
    );
  }

  // دالة لحساب حجم الخط بشكل متناسب مع عرض الشاشة
  double _getAdaptiveSize(double screenWidth, double baseSize) {
    return (baseSize * screenWidth) / 375; // 375 هو عرض الشاشة القياسي (iPhone)
  }

  Widget buildCustomCheckbox(String text, bool value, Function(bool?) onChanged, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.01,
          horizontal: screenWidth * 0.04
      ),
      child: Row(
        children: [
          SizedBox(
            height: screenWidth * 0.08,
            width: screenWidth * 0.08,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.green,
              shape: const CircleBorder(),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
              child: IntroSecondText(
                  subtitle: text,
                  color: dark,
                  size: _getAdaptiveSize(screenWidth, 15)
              )
          ),
        ],
      ),
    );
  }
}