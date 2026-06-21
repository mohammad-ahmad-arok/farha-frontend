import 'package:flutter/material.dart';
import '../../../Shared/Components/buttons.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';

class Ifemptyessentials extends StatefulWidget {
  const Ifemptyessentials({super.key});

  @override
  State<Ifemptyessentials> createState() => _IfemptyessentialsState();
}

class _IfemptyessentialsState extends State<Ifemptyessentials> {
  @override
  Widget build(BuildContext context) {
    // استخدام mediaQuery للحصول على الأبعاد بناءً على حالة الشاشة
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: light,
      body: SafeArea( // SafeArea مهمة جداً في وضع الـ Landscape لتجنب النوتش
        child: Center(
          child: SingleChildScrollView(
            // لضمان التمرير فقط عند الحاجة
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.05,
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // تصغير حجم الصورة في وضع الـ Landscape لتوفير مساحة
                  Image.asset(
                    "assets/essentials.webp",
                    width: isLandscape ? size.width * 0.2 : size.width * 0.4,
                  ),

                  SizedBox(height: size.height * 0.03),

                  IntroSecondText(
                    subtitle: "إبدأ بإضافة أساسيات مناسبتك",
                    color: dark,
                    size: isLandscape ? 20 : size.width * 0.055,
                  ),

                  SizedBox(height: size.height * 0.02),

                  // تم دمج النصوص لضمان قراءة أفضل ومنع زيادة الطول العمودي
                  Padding(
                    // تحويل البادينغ ليكون 3% من عرض الشاشة (Responsive)
                    padding: EdgeInsetsDirectional.only(
                      end: size.width * 0.03,
                    ),
                    child: IntroSecondText(
                      subtitle: "أضف الأشياء المهمة التي يجب أن تكون جاهزة قبل يوم",
                      color: orange,
                      size: isLandscape ? 14 : size.width * 0.035,
                    ),
                  ),
                  Padding(
                  // تحويل البادينغ ليكون 3% من عرض الشاشة (Responsive)
                  padding: EdgeInsetsDirectional.only(
                    end: size.width * 0.03,
                  ),
                  child: IntroSecondText(
                    subtitle: "مناسبتك ووزعها على الأشخاص المعنيين",
                    color: orange,
                    size: isLandscape ? 14 : size.width * 0.035,
                  ),
                ),

                  SizedBox(height: size.height * 0.04),

                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isLandscape ? size.width * 0.5 : double.infinity,
                    ),
                    child: BigIntroButton(
                      onPressed: () {},
                      title: 'إضافة عنصر أساسي ➕',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}