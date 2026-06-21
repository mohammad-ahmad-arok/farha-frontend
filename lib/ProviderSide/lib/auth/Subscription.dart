import 'package:flutter/material.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';

List<String> photo = ["assets/silver.png", "assets/bronze.png", "assets/golden.png"];
List<String> number = ["3000", "4000", "4000"];
List<List<String>> cardFeatures = [
  ["ميزة 1", "ميزة 2", "ميزة 3", "ميزة 4"],
  ["ميزة أ", "ميزة ب", "ميزة ج", "ميزة د"],
  ["VIP ميزة", "دعم فني", "خصم 50%", "دخول مجاني"],
];
List<Color> cardBgColors = [Color(0xFFF6F7FB), Color(0xFFFFF4E8), Color(0xFFFFF9E6)];
List<Color> cardBorderColors = [Color(0xFF565C70), Color(0xFFF4A261), Color(0xFFE0AA1F)];
List<String> text = ["الباقة الفضية", "الباقة البروزية", "الباقة الذهبية"];

class TriPageView extends StatefulWidget {
  @override
  _TriPageViewState createState() => _TriPageViewState();
}

class _TriPageViewState extends State<TriPageView> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75, initialPage: 1);
    _pageController.addListener(() {
      setState(() {
        if (_pageController.hasClients) {
          _currentPage = _pageController.page!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = screenWidth > screenHeight;
    final isTablet = screenWidth >= 600;

    // قيم متجاوبة محسنة للروتيت
    final double cardHeight = isLandscape ? screenHeight * 0.75 : (isTablet ? screenHeight * 0.6 : screenHeight * 0.55);
    final double imageHeight = isLandscape ? 50 : (isTablet ? 100 : 70);
    final double titleSize = isLandscape ? 16 : (isTablet ? 22 : 18);
    final double featureSize = isLandscape ? 11 : (isTablet ? 14 : 12);
    final double priceSize = isLandscape ? 16 : (isTablet ? 22 : 18);
    final double buttonWidth = isLandscape ? 80 : 100;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: photo.length,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              double relativePosition = index - _currentPage;
              double scale = (1 - (relativePosition.abs() * 0.15)).clamp(0.8, 1.0);
              bool isCenter = relativePosition.abs() < 0.5;

              return Transform.scale(
                scale: scale,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: cardBgColors[index],
                    border: Border.all(color: cardBorderColors[index], width: 2),
                    borderRadius: BorderRadius.circular(12), // إضافة حواف دائرية بسيطة للجمالية
                    boxShadow: [
                      if (isCenter)
                        BoxShadow(
                          color: cardBorderColors[index].withOpacity(0.2),
                          blurRadius: 10,
                        )
                    ],
                  ),
                  child: Opacity(
                    opacity: isCenter ? 1.0 : 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      // حل الاوفر فلو الجذري: سكرول داخلي للمحتوى عند ضيق المساحة
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: constraints.maxHeight),
                              child: IntrinsicHeight(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // 1. الصورة
                                    Image.asset(
                                      photo[index],
                                      height: imageHeight,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 8),
                                    // 2. العنوان
                                    IntroSecondText(
                                      subtitle: text[index],
                                      color: cardBorderColors[index],
                                      size: titleSize,
                                    ),
                                    SizedBox(height: 8),
                                    // 3. الميزات
                                    Column(
                                      children: cardFeatures[index].map((feature) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              size: featureSize + 2,
                                              color: cardBorderColors[index],
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: IntroSecondText(
                                                subtitle: feature,
                                                color: index == 0 ? Color(0xFF565C70) : Colors.black87,
                                                size: featureSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )).toList(),
                                    ),
                                    Spacer(), // يدفع السعر للأسفل إذا وجدت مساحة
                                    Divider(),
                                    // 4. السعر والزر
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        IntroSecondText(
                                          subtitle: "${number[index]} SAR",
                                          color: Colors.black, // تم التعديل لضمان الوضوح
                                          size: priceSize,
                                        ),
                                        Container(
                                          width: buttonWidth,
                                          padding: EdgeInsets.symmetric(vertical: 6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color:purple
                                          ),
                                          child: Center(
                                            child:IntroSecondText(subtitle:"اختيار", color:Colors.white, size:14)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}