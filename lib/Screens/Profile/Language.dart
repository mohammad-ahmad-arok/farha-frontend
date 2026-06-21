import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

void showLanguagePopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const LanguagePopup(),
  );
}

class LanguagePopup extends StatefulWidget {
  const LanguagePopup({super.key});

  @override
  State<LanguagePopup> createState() => _LanguagePopupState();
}

class _LanguagePopupState extends State<LanguagePopup> {
  String _selectedLanguage = 'ar'; // العربية افتراضياً

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      // تحديد عرض أقصى للنافذة في وضع اللاندسكيب لتبدو منسقة
      margin: EdgeInsets.symmetric(
        horizontal: isLandscape ? size.width * 0.2 : 0,
      ),
      decoration: const BoxDecoration(
        color: light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // شريط العنوان
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.02,
              bottom: size.height * 0.01,
            ),
            child: Row(
              children: [
                // زر العودة
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: (size.width * 0.1).clamp(35.0, 45.0),
                      height: (size.width * 0.1).clamp(35.0, 45.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new, // أيقونة أحدث وأكثر تناسقاً
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                // عنوان النافذة
                Expanded(
                  child: Center(
                    child: Text(
                      "اللغة",
                      style: TextStyle(
                        fontSize: 18, // حجم مكبر قليلاً
                        color: dark,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BahijTheSansArabic',
                      ),
                    ),
                  ),
                ),
                // مساحة توازن ليبقى العنوان في المنتصف تماماً
                SizedBox(width: size.width * 0.15),
              ],
            ),
          ),

          // خط فاصل متجاوب
          Container(
            width: size.width * 0.85,
            height: 1.5,
            color: Colors.grey[200],
          ),

          SizedBox(height: size.height * 0.03),

          // المحتوى الرئيسي
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              children: [
                // أزرار اللغات
                Row(
                  children: [
                    // زر العربية
                    _buildLanguageBtn(
                      title: "العربية",
                      langCode: 'ar',
                      size: size,
                    ),

                    SizedBox(width: size.width * 0.04),

                    // زر English
                    _buildLanguageBtn(
                      title: "English",
                      langCode: 'en',
                      size: size,
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                // زر التأكيد
                SizedBox(
                  width: double.infinity,
                  child: BigIntroButton(
                    title: 'تأكيد اختيار اللغة',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // مسافة أمان سفلية (تراعي وضعية اللاندسكيب)
                SizedBox(height: isLandscape ? size.height * 0.05 : size.height * 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // أداة بناء زر اللغة لتقليل تكرار الكود وضمان التناسق
  Widget _buildLanguageBtn({
    required String title,
    required String langCode,
    required Size size,
  }) {
    final bool isSelected = _selectedLanguage == langCode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedLanguage = langCode),
        child: Container(
          height: (size.height * 0.065).clamp(45.0, 55.0),
          decoration: BoxDecoration(
            color: isSelected ? purple : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? purple : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : dark,
                fontSize: 15, // مكبر قليلاً
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontFamily: 'BahijTheSansArabic',
              ),
            ),
          ),
        ),
      ),
    );
  }
}