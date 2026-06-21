import 'package:final_farha_pro/ProviderSide/lib/auth/socialInfo.dart';
import 'package:flutter/material.dart';
import '../../../Shared/Style/Colors.dart';
import '../shared/buttons.dart';
import '../shared/cards.dart';
import '../shared/components.dart';
import 'Info.dart';
import 'Subscription.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  int currentIndex = 0;
  final int countOfPages = 3;
  final PageController _pageController = PageController();

  final List<String> buttonTitles = ["التالي", "التالي", "إنشاء مناسبة🎉"];

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
        // أحياناً SafeArea يضيف بادينغ سفلي، إذا أردت الالتصاق التام استخدم bottom: false
        bottom: false,
        child: OrientationBuilder(
          builder: (context, orientation) {
            bool isLandscape = orientation == Orientation.landscape;

            return Column(
              children: [
                MainCard(
                  context: context,
                  title: 'إنشاء حساب مقدم خدمة',
                  subtitle: 'أنشئ حسابك وابدأ بتنظيم مناسبتك بكل سهولة',
                  onPressed: () {
                    if (currentIndex > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  isLastScreen: currentIndex == 0,
                ),

                SizedBox(height: isLandscape ? 10 : 20),

                Expanded(
                  child: isLandscape
                      ? _buildLandscapeContent()
                      : _buildPortraitContent(),
                ),

                // الأزرار هنا بدون أي Padding خارجي لتلتصق بالحواف
                _buildBottomActions(isLandscape),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomActions(bool isLandscape) {
    if (currentIndex == 2) {
      // حاوية مخصصة للصفحة الأخيرة تشبه ستايل الـ bottomBarEventDetails
      return Container(
        padding: EdgeInsets.symmetric(vertical: isLandscape ? 5 : 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: isLandscape ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.9,
              child: IntroButton(title: "انشاء الحساب"),
            ),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallCheckbox(value: false, onChanged: (bool? value) {}),
                IntroTextButton(title: 'أوافق على الشروط والأحكام', size: 12),
              ],
            ),
          ],
        ),
      );
    } else {
      return bottomBarEventDetails(
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
      );
    }
  }
  Widget _buildLandscapeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 5),
          _buildResponsiveStepper(true),
          const SizedBox(height: 10),
          Padding(
            // بادينغ يمين ويسار أكبر في الروتيت لإعطاء مظهر احترافي
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => currentIndex = index),
                children: [const Info(), const Socialinfo(), TriPageView()],
              ),
            ),
          ),
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
            // زيادة البادينغ الأفقي (horizontal) ليكون 20 مثلاً والعمودي (vertical) 13
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => currentIndex = index),
              children: [const Info(), const Socialinfo(), TriPageView()],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildResponsiveStepper(bool isLandscape) {
    final screenWidth = MediaQuery.of(context).size.width;

    // تكبير الدوائر والخطوط في الروتيت لتصبح أوضح
    final double circleSize = isLandscape ? 45.0 : screenWidth * 0.15; // كبرناها من 30 لـ 45
    final double fontSize = isLandscape ? 18.0 : screenWidth * 0.045;   // رقم الصفحة صار أوضح

    // تكبير العناوين الثلاثة تحت الدوائر
    final double titleFontSize = isLandscape ? 13.0 : screenWidth * 0.03; // كبرناها من 9 لـ 13

    // مسافات متوازنة
    final double spacing = isLandscape ? 5.0 : 8.0;
    final double horizontalGap = isLandscape ? 20.0 : screenWidth * 0.05; // زيادة المسافة بين الخطوات

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
                // الدائرة والرقم
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
                    // جعل البادينغ يمثل نسبة مئوية من حجم الدائرة (مثلاً 20% من حجمها)
                    padding: EdgeInsets.all(circleSize * 0.2),
                    child: FittedBox( // لضمان أن النص لا يخرج عن حدود الدائرة مهما كبر أو صغر
                      child: IntroSecondText(
                        subtitle: '${index + 1}',
                        color: isActive ? Colors.white : Colors.white.withOpacity(0.6),
                        size: fontSize,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spacing),
                // العناوين (صارت أكبر الآن)
                IntroSecondText(
                  subtitle: titles[index],
                  color: isActive ? dark : Colors.grey.withOpacity(0.6),
                  size: titleFontSize,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}