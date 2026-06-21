import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class Eventtype extends StatefulWidget {
  const Eventtype({super.key});

  @override
  State<Eventtype> createState() => _EventtypeState();
}

class _EventtypeState extends State<Eventtype> {
  final PageController _pageController = PageController();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController EventDateRememberController = TextEditingController();
  TextEditingController EventDateController = TextEditingController();
  TextEditingController specialDateController = TextEditingController();

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    // تعريف القياسات داخل الـ build لتتحدث عند الروتيت
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    // نستخدم shortestSide للأحجام الثابتة مثل الخطوط لضمان عدم تضخمها في الـ Landscape
    final double baseUnit = mediaQuery.size.shortestSide;

    return Scaffold(
      backgroundColor:Colors.white, // نقل اللون للخلفية الأساسية
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02), // حماية الحواف بنسبة 2%
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.035),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: "الاسم الكامل"),
              ),
              SizedBox(height: screenHeight * 0.007),
              InputField(
                hint: 'أدخل الاسم',
                controller: eventNameController,
                keyboradType: TextInputType.text,
              ),
              SizedBox(height: screenHeight * 0.035),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: "تاريخ المناسبة"),
              ),
              SizedBox(height: screenHeight * 0.007),
              DateInputField(
                hint: 'حدد التاريخ',
                controller: EventDateController,
                context: context,
                icon: const Icon(Icons.date_range_outlined),
              ),
              SizedBox(height: screenHeight * 0.035),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: "دورك في المناسبة"),
              ),
              SizedBox(height: screenHeight * 0.007),
              RoleDropdown(value: 'العريس', onChanged: (String? p1) {}),
              SizedBox(height: screenHeight * 0.035),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: "متى تريد إنهاء الترتيب بالكامل"),
              ),
              SizedBox(height: screenHeight * 0.007),
              DateInputField(
                hint: 'حدد التاريخ',
                controller: EventDateRememberController,
                context: context,
                icon: const Icon(Icons.date_range_outlined),
              ),
              SizedBox(height: screenHeight * 0.035),
              Align(
                alignment: Alignment.topRight,
                child: LabelText(label: "متى تريد التذكير بالأشياء التي تريد اصطحابها "),
              ),
              SizedBox(height: screenHeight * 0.010),

              // الخيارات (قبل يوم، صباح المناسبة، الخ)
              Row(
                children: [
                  buildOption(0, "قبل يوم", baseUnit, screenHeight),
                  buildOption(1, "صباح المناسبة", baseUnit, screenHeight),
                  buildOption(2, "وقت مخصص", baseUnit, screenHeight),
                ],
              ),

              if (selectedIndex == 2) ...[
                SizedBox(height: screenHeight * 0.02),
                DateInputField(
                  hint: 'حدد التاريخ',
                  controller: specialDateController,
                  context: context,
                  icon: const Icon(Icons.date_range_outlined),
                ),
              ],
              SizedBox(height: screenHeight * 0.05), // مسافة إضافية في الأسفل للسكرول
            ],
          ),
        ),
      ),
    );
  }

  // تعديل الـ Widget ليقبل القياسات كنسب مئوية
  Expanded buildOption(int index, String text, double baseUnit, double screenHeight) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: screenHeight * 0.065, // الارتفاع كنسبة مئوية (يعادل 48 تقريباً)
          margin: EdgeInsets.symmetric(horizontal: baseUnit * 0.01),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple : Colors.grey[300],
            borderRadius: BorderRadius.circular(baseUnit * 0.015),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : dark,
              fontSize: baseUnit * 0.038, // حجم الخط كنسبة من أصغر ضلع
              fontFamily: 'BahijTheSansArabic',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}