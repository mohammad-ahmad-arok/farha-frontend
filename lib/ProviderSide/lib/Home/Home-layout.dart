import 'package:flutter/material.dart';
import '../../../Shared/Style/Colors.dart';
import '../profile/Profile.dart';
import '../shared/components.dart';
import 'Booking.dart';
import 'Home.dart';
import 'Services.dart';


class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 3; // جعل الصفحة الرئيسية هي الافتراضية عند الفتح (أقصى اليسار في الـ RTL)

  // 1. إعادة ترتيب المصفوفة لتطابق ترتيب الأيقونات من اليمين لليسار (RTL)
  final List<Widget> screens = const [
    Profile(),  // Index 0: حسابي
    Services(), // Index 1: خدماتي
    Booking(),  // Index 2: الحجوزات
    Home(),     // Index 3: الرئيسية
  ];

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;

        // 2. تكبير حجم الزر الأوسط (FAB) بناءً على طلبك
        double navBarHeight = isLandscape ? 60 : 75; // زيادة الطول قليلاً لاستيعاب الزر الأكبر
        double fabSize = isLandscape ? 48 : 62;      // حجم متوسط (أصغر من السابق)
        double fabOffset = isLandscape ? -24 : -20;  // إزاحة متناسبة مع الحجم الجديد
        return Scaffold(
          // استخدام IndexedStack يحافظ على حالة الصفحات عند التنقل
          body: IndexedStack(
            index: currentIndex,
            children: screens,
          ),
          bottomNavigationBar: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: navBarHeight,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 2),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.white,
                      // منطق اختيار الـ index الصحيح
                      currentIndex: _getAdjustedIndex(currentIndex),
                      onTap: (index) {
                        if (index == 2) return; // تعطيل الضغط على الفراغ الأوسط
                        setState(() {
                          // تحويل index الـ Bar إلى index المصفوفة
                          currentIndex = index > 2 ? index - 1 : index;
                        });
                      },
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: purple,
                      unselectedItemColor: Colors.grey,
                      selectedFontSize: isLandscape ? 11 : 13,
                      unselectedFontSize: isLandscape ? 10 : 12,
                      selectedLabelStyle: const TextStyle(
                        fontFamily: 'BahijTheSansArabic',
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: 'BahijTheSansArabic',
                        height: 1.5,
                      ),
                      items: [
                        _buildNavItem(0, "assets/purpleprofileIcon.webp", "assets/profileIcon.webp", 'حسابي', isLandscape ? 16 : 20),
                        _buildNavItem(1, "assets/purpleServices.webp", "assets/servicesIcon.webp", 'خدماتي', isLandscape ? 18 : 22),
                        const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''), // الفراغ للزر الأوسط
                        _buildNavItem(2, "assets/purpleEventIcon.webp", "assets/eventIcon.webp", 'الحجوزات', isLandscape ? 18 : 22),
                        _buildNavItem(3, "assets/purpleHomeIcon.webp", "assets/homeIcon.webp", 'الرئيسية', isLandscape ? 20 : 24),
                      ],
                    ),
                  ),
                ),

                // زر الـ Floating Action Button المركزي (الأكبر حجماً)
                Positioned(
                  top: fabOffset,
                  child: GestureDetector(
                    onTap: () => _showAddModal(context),
                    child: Container(
                      width: fabSize,
                      height: fabSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: light, // تأكد أن لون light فاتح ليظهر الزر بوضوح
                        boxShadow: [
                          BoxShadow(
                            color: purple.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 4), // إطار أبيض ليفصله عن البار
                      ),
                      child: Icon(
                        Icons.add,
                        size: isLandscape ? 32 : 45,
                        color: purple,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // دالة مساعدة لضبط الـ Index النشط في الـ Bar
  int _getAdjustedIndex(int index) {
    return index >= 2 ? index + 1 : index;
  }

  BottomNavigationBarItem _buildNavItem(int index, String active, String inactive, String label, double iconWidth) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Image.asset(
          currentIndex == index ? active : inactive,
          width: iconWidth,
        ),
      ),
      label: label,
    );
  }

  void _showAddModal(BuildContext context) {
    // ... دالة المودال كما هي
  }
}