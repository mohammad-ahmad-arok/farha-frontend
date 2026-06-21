import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/ServicesComponent.dart';

class Prices extends StatefulWidget {
  const Prices({super.key});

  @override
  State<Prices> createState() => _PricesState();
}

class _PricesState extends State<Prices> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      // نستخدم التمرير هنا لحل مشكلة الـ Overflow في الوضع العمودي
      body: SingleChildScrollView(
        // 🛑 السر هنا: إذا كنا في وضع الروتيت، نعطل السكرول الداخلي
        // لكي لا يتضارب مع سكرول الصفحة الرئيسية
        physics: isLandscape
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ليأخذ العمود أصغر مساحة ممكنة
            children: [
              SizedBox(height: screenHeight * 0.02),

              _buildResponsiveItem(const PriceCard(), screenWidth),
              SizedBox(height: screenHeight * 0.02),

              _buildResponsiveItem(const AppointmentCard(), screenWidth),
              SizedBox(height: screenHeight * 0.02),

              _buildResponsiveItem(const addtionalCard(), screenWidth),

              // مسافة إضافية في الأسفل لضمان عدم الالتصاق بالحافة
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveItem(Widget child, double screenWidth) {
    return SizedBox(
      width: double.infinity, // يتمدد ليأخذ عرض البادينج المتاح
      child: child,
    );
  }
}