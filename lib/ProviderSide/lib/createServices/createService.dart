import 'package:final_farha_pro/ProviderSide/lib/createServices/prices.dart';
import 'package:flutter/material.dart';
import '../../../Shared/Style/Colors.dart';
import '../auth/Info.dart';
import '../auth/Subscription.dart';
import '../shared/buttons.dart';
import '../shared/cards.dart';
import '../shared/components.dart';
import 'creation.dart';
import 'mainInfo.dart';

class Createservice extends StatefulWidget {
  const Createservice({super.key});

  @override
  State<Createservice> createState() => _CreateserviceState();
}

class _CreateserviceState extends State<Createservice> {
  int currentIndex = 0;
  final int countOfPages = 3;
  final PageController _pageController = PageController();

  final List<String> buttonTitles = [
    "التالي",
    "التالي",
    "إضافة الخدمة🎉",
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: OrientationBuilder(
          builder: (context, orientation) {
            bool isLandscape = orientation == Orientation.landscape;

            return Column(
              children: [
                AppBarEventDetails(context,"إضافة خدمة معينة",showLeftButton:false),
                SizedBox(height: isLandscape ? 10 : 20),
                Expanded(
                  child: isLandscape
                      ? _buildLandscapeContent()
                      : _buildPortraitContent(),
                ),
                _buildBottomActions(isLandscape),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomActions(bool isLandscape) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLandscape ? 0 : 0),
      child: currentIndex == 2
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BigIntroButton(title: "إضافة الخدمة🎉"),
      )
          : bottomBarEventDetails(
        context,
        title: buttonTitles[currentIndex],
        onPressed: () {
          if (currentIndex < countOfPages - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }

  Widget _buildLandscapeContent() {
    // نأخذ الارتفاع المتاح للشاشة
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 5),
          _buildResponsiveStepper(true),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              // 👈 الحل هنا: يجب تحديد ارتفاع ثابت أو نسبي للـ PageView
              // في وضع الروتيت، ارتفاع الشاشة صغير، لذا سنعطيه مساحة كافية
              height: 500, // يمكنكِ استخدام screenHeight * 1.2 إذا كانت الحقول كثيرة
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => currentIndex = index),
                children: const [
                  // تأكدي أن الصفحات (Maininfo, Prices, Creation)
                  // لا تحتوي على Scaffolds أو SingleChildScrollViews داخلية
                  Maininfo(),
                  Prices(),
                  Creation()
                ],
              ),
            ),
          ),
          // مسافة إضافية في الأسفل لضمان عدم اختفاء الحقول خلف الأزرار
          const SizedBox(height: 100),
        ],
      ),
    );
  }
  Widget _buildPortraitContent() {
    return Column(
      children: [
        _buildResponsiveStepper(false),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => currentIndex = index),
              children: const [Maininfo(), Prices(), Creation()],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveStepper(bool isLandscape) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double circleSize = isLandscape ? 45.0 : screenWidth * 0.15;
    final double fontSize = isLandscape ? 18.0 : screenWidth * 0.045;
    final double titleFontSize = isLandscape ? 13.0 : screenWidth * 0.03;
    final double spacing = isLandscape ? 5.0 : 8.0;
    final double horizontalGap = isLandscape ? 20.0 : screenWidth * 0.05;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: List.generate(3, (index) {
        final isActive = index == currentIndex;
        final titles = ["معلومات أساسية", "معلومات التواصل", "سياسة الإشتراك"];

        return GestureDetector(
          onTap: () => _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalGap),
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
                    boxShadow: isActive && isLandscape
                        ? [BoxShadow(color: purple.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
                        : [],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(circleSize * 0.2),
                    child: FittedBox(
                      child: IntroSecondText(
                        subtitle: '${index + 1}',
                        color: isActive ? Colors.white : Colors.white.withOpacity(0.6),
                        size: fontSize,
                      ),
                    ),
                  ),
                ),
                if (!isLandscape) ...[
                  SizedBox(height: spacing),
                  IntroSecondText(
                    subtitle: titles[index],
                    color: isActive ? dark : Colors.grey.withOpacity(0.6),
                    size: titleFontSize,
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}