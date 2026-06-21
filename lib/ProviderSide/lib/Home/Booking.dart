import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/AppointmentComponent.dart';
import '../shared/cards.dart';
import '../shared/components.dart';
import 'FirstTime.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // الهيدر
            smallWelcomeCard(context: context, userName: "الحجوزات"),

            Expanded( // جعل بقية المحتوى قابلاً للتمرير
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // الفلتر (CustomGrayPicker)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomGrayPicker(
                        options: const ["الكل", "بانتظار التثبيت", "مثبتة", "منتهية", "ملغية"],
                        onSelected: (int p1) {},
                        dotColors: const [Colors.blue, Colors.orange, Colors.green, Colors.grey, Colors.red],
                      ),
                    ),

                    // في وضع Landscape، يمكننا وضع الكروت الصغيرة بجانب بعضها لتقليل التمرير
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isLandscape ? mediaQuery.size.width * 0.05 : 0
                      ),
                      child: const CustomMiniCardRow(),
                    ),

                    const DynamicHorizontalCalendar(),

                    // قائمة الحجوزات
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isLandscape ? mediaQuery.size.width * 0.05 : 8
                      ),
                      child: ServiceRequestCard(
                        userName: 'leda',
                        userImage: '',
                        serviceType: 'dayoub',
                        location: 'homs',
                        time: '20:00 pm',
                        date: '12/2/2026',
                        status: 'في انتظار التثبيت',
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicHorizontalCalendar extends StatefulWidget {
  const DynamicHorizontalCalendar({super.key});

  @override
  _DynamicHorizontalCalendarState createState() => _DynamicHorizontalCalendarState();
}

class _DynamicHorizontalCalendarState extends State<DynamicHorizontalCalendar> {
  final ScrollController _scrollController = ScrollController();
  DateTime selectedDate = DateTime.now();
  late List<DateTime> dateList;

  @override
  void initState() {
    super.initState();
    dateList = _generateDates();
  }

  List<DateTime> _generateDates() => List.generate(30, (index) => DateTime.now().add(Duration(days: index)));

  void _scrollTo(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String _getDayAbbreviation(DateTime date) {
    String dayName = DateFormat('EEEE', 'ar').format(date);
    if (dayName.contains('السبت')) return 'سب';
    if (dayName.contains('الأحد')) return 'أح';
    if (dayName.contains('الاثنين')) return 'اث';
    if (dayName.contains('الثلاثاء')) return 'ثلا';
    if (dayName.contains('الأربعاء')) return 'أر';
    if (dayName.contains('الخميس')) return 'خم';
    if (dayName.contains('الجمعة')) return 'جم';
    return dayName.substring(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    // تعديل الارتفاع بناءً على الاتجاه
    final double calendarHeight = isLandscape ? 60 : 75;
    // تحديد عرض الحاوية بشكل مرن
    final double containerWidth = isLandscape ? screenWidth * 0.9 : screenWidth * 0.95;

    return Center(
      child: Container(
        height: calendarHeight,
        width: containerWidth,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // في وضع Landscape نظهر عناصر أكثر (12 عنصر)، في الطولي نظهر 7 عناصر
            final int visibleItems = isLandscape ? 12 : 7;
            final itemWidth = constraints.maxWidth / (visibleItems + 0.5);

            return Row(
              children: [
                _buildArrow(Icons.arrow_back_ios, () => _scrollTo(-150)),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: dateList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      DateTime currentDate = dateList[index];
                      bool isSelected = currentDate.day == selectedDate.day &&
                          currentDate.month == selectedDate.month;

                      return GestureDetector(
                        onTap: () => setState(() => selectedDate = currentDate),
                        child: SizedBox(
                          width: itemWidth,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.purple.withOpacity(0.1) : const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? Colors.purple : Colors.grey.shade200,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${currentDate.day}",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: isLandscape ? 14 : 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _getDayAbbreviation(currentDate),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: isLandscape ? 9 : 11,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'BahijTheSansArabic',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _buildArrow(Icons.arrow_forward_ios, () => _scrollTo(150)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildArrow(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, color: Colors.purple, size: 18),
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
  }
}