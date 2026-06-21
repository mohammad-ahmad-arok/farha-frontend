import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Shared/Style/Colors.dart';
import 'buttons.dart';


Widget IntroText({required String title,required Color color}) {
  return Container(
    child: Text(
      title,
      style: TextStyle(
        fontSize:18,
        fontWeight: FontWeight.bold,
        fontFamily: 'BahijTheSansArabic', // الخط المخصص
        color:color
        // لون واضح
      ),
      maxLines:1,
    ),
  );
}
Widget IntroSecondText({
  required String subtitle,
  required Color color,
  required double size,
  bool ellipsis = false, // 👈 متحول اختياري
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        subtitle,
        maxLines: ellipsis ? 1 : 2, // 👈 سطر واحد مع نقاط
        overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
        style: TextStyle(
          textBaseline: TextBaseline.alphabetic,
          fontSize: size,
          fontFamily: 'BahijTheSansArabic',
          color: color,
        ),
      ),
    ],
  );
}
Widget LabelText({required String label}){
  return Text(label,
    style: const TextStyle(
      fontSize: 14,
      color:Colors.black,
      fontFamily: 'BahijTheSansArabic', // الخط المخصص
    ),
    textDirection:TextDirection.rtl,
    textAlign:TextAlign.end,
  );
}
Widget InputField({
  required String hint,
  required TextEditingController controller,
  required TextInputType keyboradType,
  Widget? icon,
  Function(String)? onChanged, required bool obscureText, // ✅ صار اختياري
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboradType,
    onChanged: onChanged, // ✅ آمن حتى لو null
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.right,
    style: const TextStyle(
      fontSize: 16,
      color: dark,
      fontFamily: 'BahijTheSansArabic',
    ),
    decoration: InputDecoration(
      prefixIcon: icon,
      prefixIconColor: dark,
      focusColor: purple,
      hintText: hint,
      hintTextDirection: TextDirection.rtl,
      hintStyle: const TextStyle(
        fontFamily: 'BahijTheSansArabic',
        color: lightDark,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: lightDark,
          width: 0.8,
        ),
      ),
    ),
  );
}
Widget bigInputField({
  required String hint,
  required TextEditingController controller,
  required TextInputType keyboradType,
}) {
  return Container(
    height:100,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: 10,            // ⭐ هذا اللي يضاعف الطول
      minLines: 6,            // ⭐ ثابت من البداية
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 18,
        color: dark,
        fontFamily: 'BahijTheSansArabic',
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'BahijTheSansArabic',
          color: lightDark,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: lightDark,
            width: 0.8,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: lightDark,
            width: 0.8,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: purple,
            width: 1.2,
          ),
        ),
      ),
    ),
  );
}
Widget InputDropdownField({
  required String hint,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
  Widget? icon,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    onChanged: onChanged,
    icon: const Icon(Icons.keyboard_arrow_down),
    dropdownColor: Colors.white,
    isExpanded: true,
    style: const TextStyle(
      fontSize: 16,
      color: dark,
      fontFamily: 'BahijTheSansArabic',
    ),
    decoration: InputDecoration(
      prefixIcon: icon,
      prefixIconColor: dark,
      hintText: hint,
      hintTextDirection: TextDirection.rtl,
      hintStyle: const TextStyle(
        fontFamily: 'BahijTheSansArabic',
        color: lightDark,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: lightDark,
          width: 0.8,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: lightDark,
          width: 0.8,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: purple,
          width: 1.2,
        ),
      ),
    ),
    items: items
        .map(
          (item) => DropdownMenuItem<String>(
        value: item,
        child: Align(
          alignment: Alignment.centerRight, // RTL
          child: Text(item),
        ),
      ),
    )
        .toList(),
  );
}
Widget GenderDropdown({
  required String? value,
  required void Function(String?) onChanged,
  Widget? icon,
}) {
  return Directionality(
    textDirection: TextDirection.rtl, // فرض الاتجاه
    child: DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      icon: const Icon(Icons.arrow_drop_down),
      dropdownColor: Colors.white,
      style: const TextStyle(
        fontSize: 16,
        color:dark,
        fontFamily: 'BahijTheSansArabic',
      ),
      decoration: InputDecoration(
        prefixIcon: icon,
        prefixIconColor: dark,
        focusColor: purple,
        hintText: 'الجنس',
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
          fontFamily: 'BahijTheSansArabic',
          color: lightDark
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: lightDark,
            width: 0.8,
          ),
        ),
      ),
      items: [
        DropdownMenuItem(
          value: 'ذكر',
          child: Align(
            alignment: Alignment.centerRight,
            child: IntroSecondText(subtitle: 'ذكر', color:dark, size:14 ,),
          ),
        ),
        DropdownMenuItem(
          value: 'أنثى',
          child: Align(
            alignment: Alignment.centerRight,
            child: IntroSecondText(subtitle: 'أنثى', color:dark, size:14 ,),
          ),
        ),
      ],
    ),
  );
}
Widget RoleDropdown({
  required String? value,
  required void Function(String?) onChanged,
  Widget? icon,
}) {
  return Directionality(
    textDirection: TextDirection.rtl, // فرض الاتجاه
    child: DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      icon: const Icon(Icons.arrow_drop_down),
      dropdownColor: Colors.white,
      style: const TextStyle(
        fontSize: 16,
        color:dark,
        fontFamily: 'BahijTheSansArabic',
      ),
      decoration: InputDecoration(
        prefixIcon: icon,
        prefixIconColor: dark,
        focusColor: purple,
        hintText: 'ما هو دورك',
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
            fontFamily: 'BahijTheSansArabic',
            color: lightDark
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: lightDark,
            width: 0.8,
          ),
        ),
      ),
      items: [
        DropdownMenuItem(
          value: 'العريس',
          child: Align(
            alignment: Alignment.centerRight,
            child: IntroSecondText(subtitle: 'العريس', color:dark, size:14 ,),
          ),
        ),
        DropdownMenuItem(
          value: 'العروس',
          child: Align(
            alignment: Alignment.centerRight,
            child: IntroSecondText(subtitle: 'العروس', color:dark, size:14 ,),
          ),
        ),
      ],
    ),
  );
}

Widget DateInputField({
  required String hint,
  required TextEditingController controller,
  required BuildContext context,
  Widget? icon,
}) {
  return TextFormField(
    controller: controller,
    readOnly: true, // يمنع الكيبورد
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.right,
    style: const TextStyle(
      fontSize: 16,
      color: dark,
      fontFamily: 'BahijTheSansArabic',
    ),
    onTap: () async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        locale: const Locale('ar'),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              // اللون الرئيسي للتحديد + ✓ + السهم
              colorScheme: ColorScheme.light(
                primary: purple,    // ✓ + السهم + اليوم المختار
                onPrimary: Colors.white, // النصوص في الهيدر
                onSurface: dark,    // باقي النصوص
              ),
              datePickerTheme: DatePickerThemeData(
                headerBackgroundColor: purple,
                headerForegroundColor: Colors.white,

                // التاريخ الكبير
                headerHeadlineStyle: const TextStyle(
                  fontFamily: 'BahijTheSansArabic',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),

                // ✅ الكلمة الصغيرة الرمادية (اسم الشهر + السنة)
                headerHelpStyle: const TextStyle(
                  fontFamily: 'BahijTheSansArabic',
                  fontSize: 14,
                  color: Colors.grey,   // لون رمادي
                ),

                yearStyle: const TextStyle(
                  fontFamily: 'BahijTheSansArabic',
                  fontSize: 16,
                ),
                dayStyle: const TextStyle(
                  fontFamily: 'BahijTheSansArabic',
                ),
                weekdayStyle: const TextStyle(
                  fontFamily: 'BahijTheSansArabic',
                ),

                // أزرار الإلغاء / حسناً
                confirmButtonStyle: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(purple),
                  textStyle: const MaterialStatePropertyAll(
                    TextStyle(
                      fontFamily: 'BahijTheSansArabic',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                cancelButtonStyle: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(purple),
                  textStyle: const MaterialStatePropertyAll(
                    TextStyle(
                      fontFamily: 'BahijTheSansArabic',
                      fontSize: 16,
                    ),
                  ),
                ),

                dividerColor: purple, // الخط تحت الأزرار
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(fontFamily: 'BahijTheSansArabic'),
                bodyMedium: TextStyle(fontFamily: 'BahijTheSansArabic'),
                titleLarge: TextStyle(fontFamily: 'BahijTheSansArabic'),
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        controller.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      }
    },
    decoration: InputDecoration(
      prefixIcon: icon ?? const Icon(Icons.date_range),
      prefixIconColor: dark,
      hintText: hint,
      hintTextDirection: TextDirection.rtl,
      hintStyle: const TextStyle(
        fontFamily: 'BahijTheSansArabic',
        color: lightDark,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: lightDark,
          width: 0.8,
        ),
      ),
    ),
  );
}
Container AppBarEventDetails(
    BuildContext context,
    String title, {
      String? time,
      bool showTime = false,
      bool showLeftButton = true,
    }) {
  final mediaQuery = MediaQuery.of(context);
  final screenWidth = mediaQuery.size.width;
  final screenHeight = mediaQuery.size.height;

  // التحقق من اتجاه الشاشة (أفقي أم طولي)
  final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

  // تحديد ارتفاع الهيدر: في العرض نستخدم قيمة ثابتة، في الطول نستخدم نسبة من الشاشة
  final double appBarHeight = isLandscape ? 65.0 : screenHeight * 0.11;

  return Container(
    width: double.infinity,
    height: appBarHeight,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: SafeArea(
      bottom: false,
      child: Row(
        children: [
          /// --- زر الرجوع ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                // حجم الزر يصغر قليلاً في وضع Landscape
                width: isLandscape ? 38 : screenWidth * 0.1,
                height: isLandscape ? 38 : screenWidth * 0.1,
                constraints: const BoxConstraints(
                  maxHeight: 45,
                  maxWidth: 45,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 3), // لتوسيط سهم iOS
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: isLandscape ? 16 : screenWidth * 0.045,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// --- العنوان والوقت ---
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: dark, // تأكد من تعريف dark في ملف الألوان
                    fontSize: isLandscape ? 15 : screenWidth * 0.042,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BahijTheSansArabic',
                  ),
                ),
                if (showTime && time != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      "باقي $time يوم ⏳",
                      style: TextStyle(
                        color: orange, // تأكد من تعريف orange
                        fontSize: isLandscape ? 11 : screenWidth * 0.030,
                        fontFamily: 'BahijTheSansArabic',
                      ),
                    ),
                  ),
              ],
            ),
          ),

          /// --- زر المشاركة (الشير) ---
          if (showLeftButton)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: InkWell(
                onTap: () {
                  // أضف منطق المشاركة هنا
                },
                child: Container(
                  width: isLandscape ? 38 : screenWidth * 0.1,
                  height: isLandscape ? 38 : screenWidth * 0.1,
                  constraints: const BoxConstraints(
                    maxHeight: 45,
                    maxWidth: 45,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // هذا البادينج هو المسؤول عن تصغير صورة الشير
                      child: Image.asset(
                        "assets/share.webp",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
Widget bottomBarEventDetails(BuildContext context, {required String title, required VoidCallback onPressed}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  return Container(
    width: double.infinity,
    // تصغير ارتفاع البار في الروتيت لعدم حجب المحتوى
    height: isLandscape ? 60 : MediaQuery.of(context).size.height * 0.1,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: screenWidth * 0.03,
          offset: Offset(0, -(screenWidth * 0.01)), // ظل خفيف للأعلى
        ),
      ],
    ),
    child: Center(
      child: SizedBox(
        // في الروتيت نجعل عرض الزر 50% من الشاشة بدل العرض الكامل
        width: isLandscape ? screenWidth * 0.5 : screenWidth * 0.9,
        child: BigIntroButton(
          title: title,
          onPressed: onPressed,
        ),
      ),
    ),
  );
}
class AvatarWithEdit extends StatefulWidget {
  final String? initialImageUrl;   // رابط الصورة الابتدائي (يمكن أن يكون مساراً أو null)
  final double size;
  final bool isAsset;              // إذا كانت الصورة الابتدائية من الأصول (assets)

  const AvatarWithEdit({
    super.key,
    this.initialImageUrl,
    this.size = 120,
    this.isAsset = false,
  });

  @override
  State<AvatarWithEdit> createState() => _AvatarWithEditState();
}

class _AvatarWithEditState extends State<AvatarWithEdit> {
  File? _imageFile; // الصورة المختارة من المعرض
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // الصورة الشخصية
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            image: _getImageProvider() != null
                ? DecorationImage(
              image: _getImageProvider()!,
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: _getImageProvider() == null
              ? const Icon(Icons.person, color: Colors.grey, size: 40)
              : null,
        ),
        // زر التعديل
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: widget.size * 0.3,
              height: widget.size * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.mode_edit_outlined,
                color: purple, // تأكد من تعريف purple في مكان ما
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // تحديد مصدر الصورة: إما الصورة المختارة أو الصورة الابتدائية
  ImageProvider? _getImageProvider() {
    if (_imageFile != null) {
      return FileImage(_imageFile!);
    } else if (widget.initialImageUrl != null) {
      if (widget.isAsset) {
        return AssetImage(widget.initialImageUrl!);
      } else {
        return NetworkImage(widget.initialImageUrl!);
      }
    }
    return null;
  }

  // فتح المعرض لاختيار صورة
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // اختياري: تقليل الجودة لتوفير المساحة
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      // يمكنك عرض رسالة خطأ للمستخدم
      print('خطأ في اختيار الصورة: $e');
    }
  }
}
void showCustomSnackBar(String title, String message, {bool isError = true}) {
  Get.snackbar(
    title,
    message,
    // إعدادات الخلفية واللون
    backgroundColor: isError ? Colors.red.withOpacity(0.8) : Colors.green.withOpacity(0.8),
    colorText: Colors.white,

    // تخصيص الخط والعنوان (Title)
    titleText: Text(
      title,
      textDirection: TextDirection.rtl,
      style: const TextStyle(
        fontFamily: 'BahijTheSansArabic',
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      ),
    ),

    // تخصيص الخط والرسالة (Message)
    messageText: Text(
      message,
      textDirection: TextDirection.rtl,
      style: const TextStyle(
        fontFamily: 'BahijTheSansArabic',
        color: Colors.white,
        fontSize: 14,
      ),
    ),

    // إعدادات الظهور
    snackPosition: SnackPosition.BOTTOM, // يظهر من الأسفل
    margin: const EdgeInsets.all(15),
    borderRadius: 10,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

