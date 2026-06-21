import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../Screens/EventDetails/AdaptiveLandscapeDatePicker.dart';
import '../Style/Colors.dart';


Widget IntroText({required String title,required Color color}) {
  return Container(
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
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
  bool ellipsis = false,
}) {
  return Builder(
    builder: (context) {
      final orientation = MediaQuery.of(context).orientation;
      final isLandscape = orientation == Orientation.landscape;

      // --- القاعدة الذهبية لمنع تضخم الخط ---
      // إذا كان الجهاز بالعرض، نقوم بتقليل الحجم بنسبة 30% أو نضع له سقفاً (Clamp)
      // لكي لا يتأثر بالعرض الكبير للشاشة
      double responsiveSize = isLandscape
          ? size.clamp(12.0, 18.0) // في الروتيت لا يقل عن 12 ولا يزيد عن 18
          : size;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // لضمان عدم أخذ مساحة عمودية زائدة
        children: [
          Text(
            subtitle,
            maxLines: ellipsis ? 1 : 2,
            overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
            style: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: responsiveSize, // نستخدم الحجم المعدل هنا
              fontFamily: 'BahijTheSansArabic',
              color: color,
            ),
          ),
        ],
      );
    },
  );
}
Widget LabelText({required String label}){
  return Text(label,
    style: const TextStyle(
      fontSize: 16,
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
  bool isPassword = false, // ✅ إضافة هذا السطر
  bool obscureText = false, // ✅ إضافة هذا السطر
  VoidCallback? onIconTap, // ✅ إضافة هذا السطر للتحكم بالعين
  Function(String)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboradType,
    obscureText: obscureText, // ✅ تفعيل خاصية الإخفاء
    onChanged: onChanged,
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.right,
    style: const TextStyle(
      fontSize: 16,
      color: dark,
      fontFamily: 'BahijTheSansArabic',
    ),
    decoration: InputDecoration(
      // جعلنا الأيقونة تتبدل تلقائياً إذا كان الحقل كلمة مرور
      suffixIcon: isPassword
          ? GestureDetector(
        onTap: onIconTap,
        child: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          color: dark,
        ),
      )
          : icon,
      suffixIconColor: dark,
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
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: dark,
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
    readOnly: true,
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.right,
    style: const TextStyle(fontSize: 16, color: dark, fontFamily: 'BahijTheSansArabic'),
    onTap: () async {
      bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

      if (isLandscape) {
        showDialog(
          context: context,
          builder: (context) => AdaptiveLandscapeDatePicker(
            initialDate: DateTime.now(),
            onDateSelected: (DateTime picked) {
              controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            },
          ),
        );
      } else {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          locale: const Locale('ar'),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: purple,
                  onPrimary: Colors.white,
                  onSurface: dark,
                ),
                datePickerTheme: DatePickerThemeData(
                  headerHeadlineStyle: const TextStyle(
                    fontFamily: 'BahijTheSansArabic',
                    fontSize: 18, // تصغير الخط الضخم هنا
                    fontWeight: FontWeight.bold,
                  ),
                  headerHelpStyle: const TextStyle(
                    fontFamily: 'BahijTheSansArabic',
                    fontSize: 12,
                  ),
                  dayStyle: const TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: 14),
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        }
      }
    },
    decoration: InputDecoration(
      prefixIcon: icon ?? const Icon(Icons.date_range),
      prefixIconColor: dark,
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
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



