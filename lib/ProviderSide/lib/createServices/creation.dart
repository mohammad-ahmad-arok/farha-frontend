import 'package:flutter/material.dart';
import '../../../Shared/Components/components.dart';
import '../Shared/Style/Colors.dart';

class Creation extends StatelessWidget {
  const Creation({super.key});

  @override
  Widget build(BuildContext context) {
    // جلب أبعاد الشاشة لاستخدامها كنسب مئوية
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // تعريف نسب الخطوط بناءً على عرض الشاشة
    final double titleFontSize = screenWidth * 0.045;
    final double bodyFontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: isLandscape ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
        child: Padding(
          // بادينج جانبي بنسبة 5% من عرض الشاشة
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // مسافة علوية بنسبة 3% من ارتفاع الشاشة
              SizedBox(height: screenHeight * 0.03),

              // قسم الصور (Layout) بنسب مئوية
              _buildResponsiveItem(_buildServiceLayout(context, isLandscape, screenWidth, screenHeight, bodyFontSize)),

              SizedBox(height: screenHeight * 0.025),
              _buildSectionHeader("الأسعار", titleFontSize, screenWidth),
              SizedBox(height: screenHeight * 0.015),
              _buildResponsiveItem(_buildPriceCard(screenWidth, bodyFontSize)),

              SizedBox(height: screenHeight * 0.025),
              _buildSectionHeader("الحجوزات", titleFontSize, screenWidth),
              SizedBox(height: screenHeight * 0.015),
              _buildResponsiveItem(_buildBookingCard(screenWidth, bodyFontSize)),
              SizedBox(height: screenHeight * 0.03), // مسافة سفلية للأمان
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveItem(Widget child) {
    return SizedBox(width: double.infinity, child: child);
  }

  Widget _buildSectionHeader(String title, double fontSize, double screenWidth) {
    return Row(
      children: [
        IntroSecondText(subtitle: title, color: dark, size: fontSize),
        SizedBox(width: screenWidth * 0.03),
        Expanded(child: Container(height: 1.2, color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildPriceCard(double screenWidth, double fontSize) {
    return Container(
      // بادينج داخلي بنسبة 4% من عرض الشاشة
      padding: EdgeInsets.all(screenWidth * 0.045),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(screenWidth * 0.025),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroSecondText(subtitle: "سعر ثابت :", color: dark, size: fontSize),
          SizedBox(height: screenWidth * 0.02),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontFamily: 'BahijTheSansArabic',
                  fontSize: fontSize * 0.9,
                  color: dark,
                  height: 1.5
              ),
              children: const [
                TextSpan(text: "قبل : 100\$  "),
                TextSpan(text: "بعد الخصم : 75\$", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(double screenWidth, double fontSize) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.045),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(screenWidth * 0.025),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroSecondText(subtitle: "المواعيد المتاحة", color: dark, size: fontSize),
          SizedBox(height: screenWidth * 0.02),
          IntroSecondText(subtitle: "أحد - ثلاثاء | 12:00 PM", color: secondText, size: fontSize * 0.85),
        ],
      ),
    );
  }

  Widget _buildServiceLayout(BuildContext context, bool isLandscape, double screenWidth, double screenHeight, double fontSize) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          // الارتفاع كنسبة من طول الشاشة
          height: isLandscape ? screenHeight * 0.25 : screenHeight * 0.18,
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(screenWidth * 0.025)
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => Container(
              // عرض الصورة كنسبة من عرض الشاشة
              width: isLandscape ? screenWidth * 0.15 : screenWidth * 0.28,
              margin: EdgeInsets.only(left: screenWidth * 0.03),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(screenWidth * 0.02)
              ),
              child: Icon(Icons.image, color: Colors.grey, size: screenWidth * 0.08),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          children: [
            Expanded(child: _buildSmallCard(screenWidth: screenWidth, title: "التصنيف", subtitle: "خدمات", fontSize: fontSize)),
            SizedBox(width: screenWidth * 0.03),
            Expanded(child: _buildSmallCard(screenWidth: screenWidth, title: "اسم الخدمة", subtitle: "تصوير", fontSize: fontSize)),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallCard({
    required double screenWidth,
    required String title,
    required String subtitle,
    bool isFullWidth = false,
    required double fontSize
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.035,
          vertical: screenWidth * 0.03
      ),
      decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(screenWidth * 0.02)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroSecondText(subtitle: title, color: dark, size: fontSize * 0.9),
          SizedBox(height: screenWidth * 0.01),
          IntroSecondText(subtitle: subtitle, color: secondText, size: fontSize * 0.8),
        ],
      ),
    );
  }
}