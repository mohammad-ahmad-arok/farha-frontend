import 'package:flutter/material.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';

class Maininfo extends StatefulWidget {
  const Maininfo({super.key});

  @override
  State<Maininfo> createState() => _MaininfoState();
}

class _MaininfoState extends State<Maininfo> {
  // تعريف الكنترولرز داخل الـ State
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController descriptionServiceController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();

  @override
  void dispose() {
    // تنظيف الذاكرة عند إغلاق الصفحة
    serviceController.dispose();
    descriptionServiceController.dispose();
    youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final double elementWidth = isLandscape ? screenWidth * 0.85 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: SingleChildScrollView(
          physics: isLandscape
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),

              // حاوية المرفقات
              Container(
                width: elementWidth,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_photo_alternate_outlined, color: purple, size: 28),
                    const SizedBox(height: 5),
                    IntroSecondText(subtitle: "إضافة مرفقات الخدمة", color: dark, size: 16),
                    IntroSecondText(subtitle: "الصيغ المسموحة Jpg-Png-MP4", color: secondText, size: 14)
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.02),
              _buildLabel("التصنيف"),
              CustomDropdown(
                items: const ["الكل", "خدمات", "منتجات", "استشارات"],
                onChanged: (value) {},
              ),

              SizedBox(height: screenHeight * 0.02),
              _buildLabel("اسم الخدمة"),
              CustomTextField(
                hintText: 'أدخل اسم الخدمة',
                controller: serviceController,
              ),

              SizedBox(height: screenHeight * 0.02),
              _buildLabel("وصف الخدمة"),
              _buildDescriptionField(elementWidth, isLandscape),

              SizedBox(height: screenHeight * 0.02),
              _buildLabel("رابط اليوتيوب"),
              CustomTextField(
                hintText: 'أدخل رابط اليوتيوب',
                controller: youtubeController,
                keyboardType: TextInputType.url,
              ),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 5),
        child: LabelText(label: text),
      ),
    );
  }

  Widget _buildDescriptionField(double width, bool isLandscape) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: descriptionServiceController,
        maxLines: isLandscape ? 3 : 5,
        style: const TextStyle(fontSize: 14, fontFamily: 'BahijTheSansArabic'),
        decoration: const InputDecoration(
          hintText: "أدخل وصف الخدمة",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// --- الكلاسات المطلوبة لإنهاء الخطأ (يجب أن تكون خارج _MaininfoState) ---

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({super.key, required this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text("اختر التصنيف",
              style: TextStyle(fontFamily: 'BahijTheSansArabic',
              color:Colors.grey,
              fontSize:14)),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontFamily: 'BahijTheSansArabic')),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final double scale;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      // نحدد ارتفاع ثابت متناسب مع السكيل لضمان التوسط
      height: 48 * scale,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8 * scale),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right, // التوسيط الأفقي
        keyboardType: keyboardType,
        // هذا السطر يضمن أن النص المكتوب والـ Hint على نفس الاستقامة
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14 * scale,
          fontFamily: 'BahijTheSansArabic',
          height: 1.2, // تحسين ميزان الخط العربي عمودياً
        ),
        decoration: InputDecoration(
          hintText: hintText,
          isCollapsed: true, // 👈 أهم خاصية: تزيل كل المسافات الافتراضية وتجعل النص في السنتر
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14 * scale,
            fontFamily: 'BahijTheSansArabic',
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}