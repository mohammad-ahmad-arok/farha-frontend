import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Shared/Style/Colors.dart';

class AdaptiveLandscapeDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const AdaptiveLandscapeDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = initialDate;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Container(
        // عرض مريح للروتيت لضمان عدم حدوث Overflow
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.65,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // القسم الخاص بالعجلات (Cupertino Picker)
            Expanded(
              flex: 2,
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      fontFamily: 'BahijTheSansArabic',
                      fontSize: 18,
                      color: dark,
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ),

            // فاصل عمودي أنيق
            VerticalDivider(color: Colors.grey.shade300, thickness: 1, indent: 10, endIndent: 10),

            // قسم التحكم والأزرار
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit_calendar_rounded, color: purple, size: 30),
                  const SizedBox(height: 10),
                  const Text(
                    "تعديل التاريخ",
                    style: TextStyle(
                      fontFamily: 'BahijTheSansArabic',
                      fontWeight: FontWeight.bold,
                      color: dark,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      onDateSelected(tempDate);
                      Navigator.pop(context);
                    },
                    child: const Text("تأكيد", style: TextStyle(color: Colors.white, fontFamily: 'BahijTheSansArabic')),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("إلغاء", style: TextStyle(color: Colors.grey, fontFamily: 'BahijTheSansArabic')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}