import 'package:flutter/material.dart';

import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/EventPreparation/PreparationComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class Addessentialitem extends StatefulWidget {
  const Addessentialitem({super.key});

  @override
  State<Addessentialitem> createState() => _AddessentialitemState();
}

class _AddessentialitemState extends State<Addessentialitem> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  List<String> taskTypes = [];

  @override
  Widget build(BuildContext context) {
    // 1. حساب الأبعاد الأساسية
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;

    // استخدام shortestSide يضمن أن الحجم لا ينفجر عند التدوير
    final double baseUnit = mediaQuery.size.shortestSide;
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: light,
        body: SafeArea(
          child: Column(
            children: [
              // الهيدر
              _buildHeader(screenWidth, screenHeight, baseUnit),

              const Divider(color: Colors.grey, thickness: 1, height: 1),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: isLandscape ? screenHeight * 0.02 : screenHeight * 0.03
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("المهمة الأساسية", baseUnit),
                      SizedBox(height: screenHeight * 0.015),
                      InputField(
                        hint: 'اكتب المهمة هنا',
                        controller: itemController,
                        keyboradType: TextInputType.text,
                      ),

                      SizedBox(height: isLandscape ? screenHeight * 0.05 : screenHeight * 0.04),

                      _buildLabel("ملاحظات", baseUnit),
                      SizedBox(height: screenHeight * 0.015),
                      bigInputField(
                        hint: 'اكتب التفاصيل هنا',
                        controller: notesController,
                        keyboradType: TextInputType.multiline,
                      ),

                      SizedBox(height: isLandscape ? screenHeight * 0.05 : screenHeight * 0.04),

                      _buildLabel("مخصص ل:", baseUnit),
                      SizedBox(height: screenHeight * 0.015),
                      CustomMultiSelect(
                        onChanged: (List<String> values) {
                          setState(() => taskTypes = values);
                        },
                      ),

                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: (isLandscape && mediaQuery.viewInsets.bottom > 0)
            ? const SizedBox.shrink()
            : bottomBarEventDetails(title: 'تأكيد', onPressed: () {}, context),
      ),
    );
  }

  // تعديل الهيدر ليستخدم baseUnit بدلاً من العرض الكلي
  Widget _buildHeader(double width, double height, double baseUnit) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              // هنا السر: استخدمنا baseUnit (البعد الأصغر)
              // لتبقى الدائرة ثابتة الحجم تقريباً عند التدوير
              width: baseUnit * 0.11,
              height: baseUnit * 0.11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: baseUnit * 0.045, // حجم السهم متناسق مع الدائرة
                  color: dark,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          IntroSecondText(
            subtitle: "إضافة عنصر أساسي",
            color: dark,
            size: baseUnit * 0.048, // حجم الخط يعتمد على البعد الأصغر أيضاً
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, double baseUnit) {
    return IntroSecondText(
      subtitle: text,
      color: dark,
      size: baseUnit * 0.042, // حجم الليبل متناسق
    );
  }
}