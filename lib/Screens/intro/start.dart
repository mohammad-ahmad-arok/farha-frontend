import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Constants/constants.dart';
import '../../Shared/Style/Colors.dart';
import 'intro4.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // تغليف المحتوى بـ PopScope لمنع الرجوع للـ Splash
      body: PopScope(
        canPop: false, // يمنع الرجوع من الزر الفعلي أو السحب
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isLandscape = constraints.maxWidth > constraints.maxHeight;
            double screenHeight = constraints.maxHeight;
            double screenWidth = constraints.maxWidth;

            return Directionality(
              textDirection: TextDirection.ltr,
              child: PageView.builder(
                controller: _pageController,
                itemCount: intro.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // 1. الصورة مع التلاشي الحقيقي
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: isLandscape ? screenHeight * 0.98 : screenHeight * 0.88,
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [0.0, 0.6, 0.95],
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.asset(
                              "assets/intro${index + 1}.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // 2. المحتوى الأبيض
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SmoothPageIndicator(
                                  controller: _pageController,
                                  count: intro.length,
                                  effect: WormEffect(
                                    dotHeight: screenHeight * 0.009,
                                    dotWidth: screenHeight * 0.009,
                                    activeDotColor: Colors.purple,
                                    dotColor: Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Column(
                                    children: [
                                      IntroText(title: intro[index], color: const Color(0xFF2C2F31)),
                                      SizedBox(height: screenHeight * 0.01),
                                      IntroSecondText(
                                        subtitle: subIntro[index],
                                        color: const Color(0xFF5F6368),
                                        size: isLandscape ? 13 : 15,
                                      ),
                                      IntroSecondText(
                                        subtitle: subIntro2[index],
                                        color: const Color(0xFF5F6368),
                                        size: isLandscape ? 13 : 15,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.03),
                                // ... داخل الـ Column الخاص بالأزرار
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: isLandscape ? screenWidth * 0.4 : screenWidth * 0.85
                                    ),
                                    child: Column(
                                      children: [
                                        IntroButton(
                                          title: index == 2 ? 'المتابعة الى التطبيق' : "التالي",
                                          onPressed: () {
                                            index == 2
                                                ? Get.off(() => const Intro4())
                                                : _pageController.nextPage(
                                                duration: const Duration(milliseconds: 300),
                                                curve: Curves.easeInOut);
                                          },
                                        ),

                                        // استخدام الشرط مع نسبة مئوية للطول
                                        if (index == 1 || index == 2)
                                          IntroTextButton(
                                            onPressed: () {
                                              _pageController.previousPage(
                                                  duration: const Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut);
                                            },
                                            title: 'رجوع',
                                            size: 14,
                                          )
                                        else
                                        // نستخدم نسبة مئوية من ارتفاع الشاشة لتعويض مكان الزر
                                        // 0.05 تعني 5% من ارتفاع الشاشة، يمكنك زيادتها أو تقليلها لتطابق حجم الزر تماماً
                                          SizedBox(height: isLandscape ? screenHeight * 0.08 : screenHeight * 0.05),

                                        SizedBox(height: screenHeight * 0.02),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 3. اللوجو
                        Positioned(
                          top: isLandscape ? screenHeight * 0.05 : screenHeight * 0.08,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset(
                              index == 1 ? "assets/gray.webp" : "assets/white.webp",
                              width: isLandscape ? screenWidth * 0.12 : screenWidth * 0.32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}