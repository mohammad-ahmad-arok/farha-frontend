import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Controllers/bookingController.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final EventController controller = Get.find<EventController>();

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Map<DateTime, List<String>> availableTimes = {};
  List<String> selectedTimes = [];

  @override
  void initState() {
    super.initState();
    availableTimes = {
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
        '09:00 AM', '11:00 AM', '01:00 PM', '03:00 PM', '05:00 PM'
      ],
      DateTime(2026, 2, 10): ['10:00 AM', '12:00 PM', '02:00 PM', '04:00 PM'],
    };

    final todayKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    selectedTimes = availableTimes[todayKey] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final double baseUnit = size.shortestSide; // الضلع الأصغر (العرض في البورتريه، الطول في الروتيت)

    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        title: IntroSecondText(subtitle: 'اختيار التاريخ والوقت', color: dark, size: baseUnit * 0.045),
        backgroundColor: light,
        elevation: 0,
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: isLandscape
            ? _buildLandscapeLayout(size, baseUnit)
            : _buildPortraitLayout(size, baseUnit),
      ),
    );
  }

  // ================== واجهة الـ Landscape (الروتيت) بجميع القيم ريسبونسف ==================
  Widget _buildLandscapeLayout(Size size, double baseUnit) {
    return Row(
      children: [
        // القسم الأيمن: التقويم مع بادينغ سفلي ريسبونسف
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: size.height * 0.15, // بادينغ سفلي تحت الكلايندر 15% من الارتفاع
              left: size.width * 0.02,
              right: size.width * 0.02,
              top: size.height * 0.02,
            ),
            child: _buildCalendarSection(baseUnit),
          ),
        ),

        // القسم الأيسر: الأوقات مع الزر المخصص للروتيت
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IntroSecondText(subtitle: "الأوقات المتاحة", color: dark, size: baseUnit * 0.05),
                ),
              ),
              Expanded(child: _buildTimesGrid(baseUnit, isLandscape: true, size: size)),
              _buildBottomAction(isLandscape: true, size: size, baseUnit: baseUnit),
            ],
          ),
        ),
      ],
    );
  }

  // ================== واجهة الـ Portrait (الطولي) ==================
  Widget _buildPortraitLayout(Size size, double baseUnit) {
    return Column(
      children: [
        _buildCalendarSection(baseUnit),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Align(
            alignment: Alignment.centerRight,
            child: IntroSecondText(subtitle: "الأوقات المتاحة للحجوزات", color: dark, size: baseUnit * 0.05),
          ),
        ),
        Expanded(child: _buildTimesGrid(baseUnit, isLandscape: false, size: size)),
        _buildBottomAction(isLandscape: false, size: size, baseUnit: baseUnit),
      ],
    );
  }

  // التقويم بقيم ريسبونسف
  Widget _buildCalendarSection(double baseUnit) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      rowHeight: baseUnit * 0.11, // ارتفاع الصف كنسبة من baseUnit
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          controller.selectedDate.value = selectedDay;
          final key = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
          selectedTimes = availableTimes[key] ?? [];
          controller.selectedTime.value = "";
        });
      },
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: baseUnit * 0.05, fontWeight: FontWeight.bold),
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: baseUnit * 0.04),
        selectedTextStyle: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: baseUnit * 0.04, color: Colors.white),
        selectedDecoration: BoxDecoration(color: purple, shape: BoxShape.circle),
        todayDecoration: BoxDecoration(color: purple.withOpacity(0.3), shape: BoxShape.circle),
      ),
    );
  }

  // شبكة الأوقات بقيم ريسبونسف
  Widget _buildTimesGrid(double baseUnit, {required bool isLandscape, required Size size}) {
    return selectedTimes.isEmpty
        ? Center(child: Text('لا يوجد أوقات متاحة', style: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: baseUnit * 0.04)))
        : GridView.builder(
      padding: EdgeInsets.all(size.width * 0.03),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 2 : 3,
        mainAxisSpacing: size.height * 0.015,
        crossAxisSpacing: size.width * 0.02,
        childAspectRatio: isLandscape ? 2.8 : 2.4,
      ),
      itemCount: selectedTimes.length,
      itemBuilder: (context, index) {
        return Obx(() {
          bool isSelected = controller.selectedTime.value == selectedTimes[index];
          return GestureDetector(
            onTap: () => controller.selectedTime.value = selectedTimes[index],
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? purple : Colors.grey[300],
                borderRadius: BorderRadius.circular(baseUnit * 0.025),
              ),
              child: Text(
                selectedTimes[index],
                style: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: baseUnit * 0.035, color: isSelected ? Colors.white : dark),
              ),
            ),
          );
        });
      },
    );
  }

  // الزر المخصص (تغيير البوتوم بار إلى زر في الروتيت مع بادينغ جانبي)
  Widget _buildBottomAction({required bool isLandscape, required Size size, required double baseUnit}) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Center(child: CircularProgressIndicator(color: purple)),
        );
      }

      if (isLandscape) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, // بادينغ جانبي 5%
            vertical: size.height * 0.03, // بادينغ سفلي 3%
          ),
          child: SizedBox(
            width: double.infinity,
            height: size.height * 0.12, // ارتفاع الزر نسبة من الطول
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(baseUnit * 0.02)),
              ),
              onPressed: () => _handleBooking(),
              child: Text(
                "تأكيد الحجز الآن",
                style: TextStyle(fontFamily: 'BahijTheSansArabic', color: Colors.white, fontSize: baseUnit * 0.04, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }

      return bottomBarEventDetails(
        context,
        title: "تأكيد الحجز الآن",
        onPressed: () => _handleBooking(),
      );
    });
  }

  void _handleBooking() async {
    if (controller.selectedTime.value.trim().isEmpty) {
      Get.snackbar("تنبيه", "يرجى اختيار الوقت المناسب قبل التأكيد",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange, colorText: Colors.white);
    } else {
      await controller.submitBooking();
    }
  }
}