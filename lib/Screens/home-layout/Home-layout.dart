import 'package:flutter/material.dart';
import '../../Shared/Components/ServiceProvider/ServicesProviderComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import '../EventPreparing/MyEvents.dart';
import '../Profile/Profile.dart';
import 'Home.dart';
import 'Plans.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  // الترتيب الصحيح للمصفوفة (يتوافق مع أرقام navIndex أدناه)
  final List<Widget> screens = const [
    Home(),       // Index 0
    Plans(),      // Index 1
    Myevents(),   // Index 2
    Profile(),    // Index 3
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final screenWidth = mediaQuery.size.width;

    return PopScope(
      canPop: false, // يمنع الرجوع تماماً
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (currentIndex != 0) {
          setState(() {
            currentIndex = 0;
          });
        } else {
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: screens[currentIndex],
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              height: 60,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  // حساب الـ Index الظاهري مع مراعاة الفراغ في المنتصف
                  currentIndex: currentIndex >= 2 ? currentIndex + 1 : currentIndex,
                  onTap: (index) {
                    if (index == 2) return; // مكان زر الـ (+) الوهمي
                    setState(() {
                      // تحويل الـ index من شريط التنقل إلى index المصفوفة الحقيقي
                      currentIndex = index > 2 ? index - 1 : index;
                    });
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: purple,
                  unselectedItemColor: Colors.grey,
                  selectedLabelStyle: const TextStyle(
                    fontFamily: 'BahijTheSansArabic',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: 'BahijTheSansArabic',
                    fontSize: 11,
                  ),
                  items: [
                    // الرئيسية (Index 0 في المصفوفة)
                    _buildNavItem(0, "assets/purpleHomeIcon.webp", "assets/homeIcon.webp", 'الرئيسية', 20),
      
                    // مخططاتي (Index 1 في المصفوفة)
                    _buildNavItem(1, "assets/purplefav.webp", "assets/fav.webp", 'مفضلة', 18.5),
      
                    // عنصر وهمي للـ +
                    const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
      
                    // مناسباتي (Index 2 في المصفوفة)
                    _buildNavItem(2, "assets/purpleEventIcon.webp", "assets/eventIcon.webp", 'مناسباتي', 18.75),
      
                    // حسابي (Index 3 في المصفوفة)
                    _buildNavItem(3, "assets/purpleprofileIcon.webp", "assets/profileIcon.webp", 'حسابي', 16),
                  ],
                ),
              ),
            ),
      
            /// زر + المتجاوب
            Positioned(
              top: isLandscape ? -30 : -screenWidth * 0.08,
              child: _buildFloatingButton(context, isLandscape),
            )
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(int navIndex, String activeIcon, String inactiveIcon, String label, double width) {
    // الآن currentIndex سيتطابق تماماً مع navIndex الممرر
    bool isActive = currentIndex == navIndex;

    return BottomNavigationBarItem(
      icon: Image.asset(
        isActive ? activeIcon : inactiveIcon,
        width: width,
        key: ValueKey('${isActive}_$navIndex'),
        color: null,
      ),
      label: label,
    );
  }

  Widget _buildFloatingButton(BuildContext context, bool isLandscape) {
    final size = MediaQuery.of(context).size;
    final buttonSize = isLandscape ? 50.0 : size.width * 0.18;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.add, size: buttonSize * 0.5, color: purple),
        onPressed: () => _showAddEventSheet(context, isLandscape),
      ),
    );
  }

  void _showAddEventSheet(BuildContext context, bool isLandscape) {
    final size = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          // استخدام نسبة مئوية للحواف (مثلاً 4% من عرض الشاشة)
          padding: EdgeInsets.all(size.width * 0.04),
          height: isLandscape ? size.height * 0.8 : size.height * 0.45,
          child: SingleChildScrollView(
            child: Column(
              children: [
                IntroSecondText(subtitle: "اختر مناسبتك", color: dark, size: 20),
                const Divider(),

                // مسافة تعادل 2% من ارتفاع الشاشة
                SizedBox(height: size.height * 0.02),

                _buildEventRow(['تخرج', 'ولادة'], ['assets/graduate.webp', 'assets/babyBirth.webp']),

                // مسافة تعادل 2% من ارتفاع الشاشة
                SizedBox(height: size.height * 0.02),

                _buildEventRow(['زواج', 'أعياد ميلاد'], ['assets/married.webp', 'assets/birthday.webp']),
              ],
            ),
          ),
        );
      },
    );
  }

// تعديل الدالة المساعدة أيضاً لتستخدم النسبة المئوية في العرض (Width)
  Widget _buildEventRow(List<String> titles, List<String> images) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterCard(image: images[0], type: titles[0], context: context),

        // مسافة عرضية تعادل 8% من عرض الشاشة بدلاً من الرقم الثابت 30
        SizedBox(width: screenWidth * 0.08),

        FilterCard(image: images[1], type: titles[1], context: context),
      ],
    );
  }
}