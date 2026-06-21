import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import 'AddPepoleScreen.dart';
import 'CreatEventPopUp.dart';
import 'EventInformation.dart' hide Addpepolescreen;
import 'EventType.dart';

class Eventdetails extends StatefulWidget {
  const Eventdetails({super.key});

  @override
  State<Eventdetails> createState() => _EventdetailsState();
}

int currentIndex = 0;
final countOfPages = 3;
final List<String> appBarTitles = [
  "أخبرنا عن مناسبتك",
  "من سيشاركك هذه المناسبة؟",
  "تأكد من معلومات مناسبتك",
];
final List<String> ButtonTitles = [
  "التالي",
  "التالي",
  "إنشاء مناسبة🎉"
];

class _EventdetailsState extends State<Eventdetails> {
  final PageController _pageController = PageController();
  final EventData eventData = EventData();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double baseUnit = mediaQuery.size.shortestSide;
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor:Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Transform.translate(
            offset: Offset(0, isLandscape ? -10 : -16),
            child: Padding(
              padding: EdgeInsets.only(
                top: isLandscape ? 0 : MediaQuery.of(context).padding.top,
                bottom: 0,
              ),
              child: AppBarEventDetails(
                  context,
                  appBarTitles[currentIndex],
                  showLeftButton: false
              ),
            ),
          ),

          _buildStepper(baseUnit, isLandscape, screenWidth),

          SizedBox(height: isLandscape ? 5 : 7),

          // 3. Content Area (PageView)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: baseUnit * 0.035,
              ),
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: [
                  Eventtype(),
                  Addpepolescreen(),
                  EventInformation(),
                ],
              ),
            ),
          ),

          // 4. Bottom Bar (تم إضافة بادينغ سفلي للروتيت)
          Container(
            padding: EdgeInsets.only(
              bottom: isLandscape ? 15 : 0, // مسافة تحت الزر في وضع الروتيت
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: bottomBarEventDetails(
              context,
              title: ButtonTitles[currentIndex],
              onPressed: () {
                if (currentIndex < countOfPages - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Get.to(Createventpopup());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ميثود الـ Stepper مع تعديلات المسافات
  Widget _buildStepper(double baseUnit, bool isLandscape, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isLandscape ? 15 : 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textDirection: TextDirection.rtl,
        children: List.generate(3, (index) {
          final isActive = index == currentIndex;
          final titles = ["معلومات أساسية", "إضافة الأشخاص", "مراجعة وإنشاء"];

          final circleSize = isLandscape ? baseUnit * 0.1 : baseUnit * 0.14;
          final fontSize = isLandscape ? 11.0 : 13.0; // تصغير الخط درجة واحدة ليناسب المساحة

          return GestureDetector(
            onTap: () => _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut),
            child: SizedBox(
              // تم زيادة العرض قليلاً ليتسع للكلمات الطويلة
              width: screenWidth / 3.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? purple : Colors.grey[300],
                      boxShadow: isActive ? [
                        BoxShadow(
                          color: purple.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ] : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: isLandscape ? 14 : 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    titles[index],
                    textAlign: TextAlign.center,
                    // تم إلغاء maxLines أو زيادتها لضمان ظهور النص كاملاً
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      color: isActive ? dark : Colors.grey[600],
                      fontSize: fontSize,
                      height: 1.2, // تقليل المسافة بين السطرين إذا نزل النص لسطر جديد
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      fontFamily: 'BahijTheSansArabic',
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }}

// الكلاس المخصص للروتيت (لم يتغير)
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
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.65,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
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
            VerticalDivider(color: Colors.grey.shade300, thickness: 1, indent: 10, endIndent: 10),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit_calendar_rounded, color: Colors.purple, size: 30),
                  const SizedBox(height: 10),
                  const Text(
                    "تعديل التاريخ",
                    style: TextStyle(fontFamily: 'BahijTheSansArabic', fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      onDateSelected(tempDate);
                      Navigator.pop(context);
                    },
                    child: const Text("تأكيد", style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
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

class EventData {
  String eventName = '';
  DateTime? eventDate;
  String role = '';
  DateTime? finishDate;
  String reminderType = '';
  DateTime? customReminderDate;
  List<Map<String, dynamic>> people = [];
}