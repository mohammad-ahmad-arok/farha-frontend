import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../Screens/EventPreparing/TodoList1.dart';
import '../../../Screens/ServicesProvider/EventCardDetailsScreen.dart';
import '../../../Screens/ServicesProvider/ServicesProviderHome.dart';
import '../../Style/Colors.dart';
import '../buttons.dart';
import '../components.dart';

//////////////////////SevicesProvider
Widget AppBarServicesProvider({
  required BuildContext context,
  required String name,
  required double rate,
}) {
  return OrientationBuilder(
    builder: (context, orientation) {
      final isLandscape = orientation == Orientation.landscape;
      final size = MediaQuery.of(context).size;

      // الحل السحري: نستخدم أصغر ضلع في الموبايل كمرجع (غالباً هو العرض في Portrait)
      // هذا الرقم يبقى ثابتاً حتى لو دورتي الموبايل
      final ref = size.shortestSide;

      // قياسات الروتيت (Landscape) - جعلناها أصغر يدوياً
      final double coverHeight = isLandscape ? size.height * 0.4 : size.height * 0.22;

      // هنا السر: نضرب في معامل صغير جداً في الروتيت لتصغير العناصر
      final double avatarRadius = isLandscape ? ref * 0.08 : ref * 0.12;
      final double iconBoxSize = isLandscape ? ref * 0.09 : ref * 0.1;
      final double iconSize    = isLandscape ? ref * 0.04 : ref * 0.05;

      return Container(
        margin: EdgeInsets.only(bottom: isLandscape ? 10 : 0),
        height: coverHeight + (avatarRadius / 2),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. الكفر العلوي
            Container(
              width: size.width,
              height: coverHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(isLandscape ? 15 : ref * 0.04)
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/cover.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
        padding: EdgeInsets.symmetric(
        // في الروتيت نجعل الحواف 0 ليلتصق الزر بالطرف، وفي العادي نترك مسافة
        horizontal: isLandscape ? 0 : size.width * 0.03,
          vertical: isLandscape ? 6 : MediaQuery.of(context).padding.top + 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(isLandscape ? 15 : ref * 0.04)
          ),
          color: Colors.black.withOpacity(0.2),
        ),
        // هنا نضمن أن العناصر تبدأ من الأعلى
        alignment: Alignment.topCenter,
        child: Row(
          // MainAxisAlignment.spaceBetween سيضع زر الرجوع في أقصى اليمين
          // والأيقونات الأخرى في أقصى اليسار (بسبب الـ RTL)
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _circleIcon(
                size,
                Icons.arrow_back_ios_sharp,
                customSize: iconBoxSize,
                iconSize: iconSize,
                onTap: () => Navigator.pop(context)
            ),
            Row(
              children: [
                _circleIcon(size, Icons.share_outlined,
                    customSize: iconBoxSize, iconSize: iconSize, onTap: () {}),
                SizedBox(width: isLandscape ? 8 : 10),
                _circleIcon(size, Icons.favorite_border,
                    customSize: iconBoxSize, iconSize: iconSize, onTap: () {}),
                // نضع مسافة صغيرة جداً في النهاية بالروتيت
                if(isLandscape) SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
            ),

            // 2. الأفاتار والمعلومات
            Positioned(
              bottom: -avatarRadius / 2,
              left: isLandscape ? size.width * 0.1 : size.width * 0.05,
              right: isLandscape ? size.width * 0.1 : size.width * 0.05,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: isLandscape ? 1.5 : 3),
                    ),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: avatarRadius - (isLandscape ? 1 : 2),
                        backgroundImage: const AssetImage('assets/cover.jpg'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: IntroText(
                            title: name,
                            color: dark,
                            // تأكدي أن IntroText لا يسبب خطأ الآن
                          ),
                        ),
                        Rate(rate: rate, size: size, context: context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

// ويدجت الأيقونة مع دعم الحجم الصغير جداً
Widget _circleIcon(Size size, IconData icon, {double? customSize, double? iconSize, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: customSize,
      height: customSize,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: purple,
          size: iconSize,
        ),
      ),
    ),
  );
}
Widget Rate({required double rate, required Size size, required BuildContext context}) {
  // يجب أن يكون التعريف داخل الويدجت للوصول للـ context الصحيح
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  return Container(
    // تعديل العرض ليكون مرناً (Wrap Content) في الروتيت ليناسب النص
    width: isLandscape ? size.width * 0.12 : size.width * 0.18,
    height: isLandscape ? size.height * 0.08 : size.height * 0.035,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size.width * 0.01),
      color: const Color(0xFFFFF1C4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          // تصغير النجمة في الروتيت كما طلبت
          size: isLandscape ? size.width * 0.03 : size.width * 0.05,
        ),
        SizedBox(width: size.width * 0.01),
        IntroSecondText(
          subtitle: rate.toString(),
          color: dark,
          // تصغير حجم الخط أيضاً في الروتيت ليتناسق مع النجمة
          size: isLandscape ? size.width * 0.03 : size.width * 0.045,
        ),
      ],
    ),
  );
}
Widget ServiceCard({
  required BuildContext context,
  required String imageUrl,
  required String serviceName,
  required String description,
  required String duration,
  required double priceBeforeDiscount,
  double? priceAfterDiscount,
  double? discountPercent,
  bool isFavorite = false,
  required String category,
  required String provider,
  required String specificType,
  required String eventType,
}) {
  final size = MediaQuery.of(context).size;
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  // قياسات موحدة ومتجاوبة
  final cardRadius = BorderRadius.circular(size.width * 0.03);
  final cardHeight = isLandscape ? size.height * 0.42 : size.height * 0.19;
  final imageWidth = isLandscape ? size.width * 0.22 : size.width * 0.28;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventCardDetails(
            imageUrl: imageUrl,
            serviceName: serviceName,
            description: description,
            duration: duration,
            priceBeforeDiscount: priceBeforeDiscount,
            priceAfterDiscount: priceAfterDiscount,
            discountPercent: discountPercent,
            category: category,
            provider: provider,
            specificType: specificType,
            eventType: eventType,
            images: [imageUrl],
          ),
        ),
      );
    },
    child: Container(
      width: size.width * 0.92,
      height: cardHeight,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: cardRadius,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: cardRadius,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(isLandscape ? 6 : size.width * 0.02),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: cardRadius,
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  // ================== القسم الأيمن: الصورة والمفضلة ==================
                  Stack(
                    children: [
                      Container(
                        width: imageWidth,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: CircleAvatar(
                          radius: isLandscape ? 14 : size.width * 0.075,
                          backgroundColor: Colors.white.withOpacity(0.9),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: isLandscape ? 16 : size.width * 0.05,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: isLandscape ? 12 : size.width * 0.04),

                  // ================== القسم الأيسر: المعلومات ==================
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // التاغات (Tags)
                          Row(
                            children: [
                              _buildSmallTag(eventType, isLandscape),
                              const SizedBox(width: 5),
                              _buildSmallTag(category, isLandscape),
                            ],
                          ),

                          // اسم الخدمة
                          Text(
                            serviceName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: isLandscape ? 14 : 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BahijTheSansArabic',
                              color: Colors.black87,
                            ),
                          ),

                          // الوصف المختصر
                          Text(
                            description,
                            maxLines: isLandscape ? 1 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: isLandscape ? 10 : 12,
                              color: Colors.grey[600],
                              fontFamily: 'BahijTheSansArabic',
                            ),
                          ),

                          // الوقت والسعر في سطر واحد
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: isLandscape ? 12 : 14, color: Colors.grey),
                                  const SizedBox(width: 2),
                                  Text(
                                    duration,
                                    style: TextStyle(fontSize: isLandscape ? 10 : 12),
                                  ),
                                ],
                              ),
                              _buildPrice(priceBeforeDiscount, priceAfterDiscount, isLandscape),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ================== شريط الخصم المائل ==================
            if (discountPercent != null)
              Positioned(
                top: isLandscape ? 6 : 10,
                left: isLandscape ? -22 : -28,
                child: Transform.rotate(
                  angle: -0.78,
                  child: Container(
                    width: isLandscape ? 80 : 100,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    color: Colors.orange,
                    child: Center(
                      child: Text(
                        "${discountPercent.toStringAsFixed(0)}% OFF",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isLandscape ? 8 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

// ويدجت مساعد للتاغات لتقليل تكرار الكود
Widget _buildSmallTag(String text, bool isLandscape) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: isLandscape ? 9 : 11,
        fontFamily: 'BahijTheSansArabic',
      ),
    ),
  );
}

// ويدجت مساعد لعرض السعر
Widget _buildPrice(double before, double? after, bool isLandscape) {
  return Row(
    children: [
      if (after != null) ...[
        Text(
          "$after ل.س",
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: isLandscape ? 11 : 13,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          "$before",
          style: TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
            fontSize: isLandscape ? 9 : 11,
          ),
        ),
      ] else
        Text(
          "$before ل.س",
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: isLandscape ? 11 : 13,
          ),
        ),
    ],
  );
}

// ويدجت مساعد للـ Tags
Widget _buildTag(String text, Size size, bool isLandscape) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: isLandscape ? 2 : 4),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: isLandscape ? size.width * 0.025 : size.width * 0.032,
        color: Colors.black87,
        fontFamily: 'BahijTheSansArabic',
      ),
    ),
  );
}

// ويدجت مساعد للسعر
Widget _buildPriceSection(double before, double? after, Size size, bool isLandscape) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (after != null) ...[
        IntroSecondText(
          subtitle: "$after ل.س",
          color: Colors.orange,
          size: isLandscape ? size.width * 0.03 : size.width * 0.038,
        ),
        const SizedBox(width: 8),
        Text(
          "$before",
          style: TextStyle(
            color: Colors.grey,
            fontSize: isLandscape ? size.width * 0.025 : size.width * 0.03,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ] else
        IntroSecondText(
          subtitle: "$before ل.س",
          color: Colors.orange,
          size: isLandscape ? size.width * 0.03 : size.width * 0.038,
        ),
    ],
  );
}

Widget ServiceCardVertical({
  required BuildContext context,
  required String imageUrl,
  required String serviceName,
  required String description,
  required String duration,
  required double priceBeforeDiscount,
  double? priceAfterDiscount,
  bool isFavorite = false,
  required String category,
  required String provider,
  required String specificType,
  required String eventType,
  VoidCallback? onTap,
}) {
  final size = MediaQuery.of(context).size;
  final orientation = MediaQuery.of(context).orientation;
  final bool isPortrait = orientation == Orientation.portrait;

  // مرجع للأحجام الصغيرة لضمان التناسق
  final double responsiveRef = size.shortestSide;

  // --- ضبط المقاسات الخارجية بالنسب ---
  final double cardWidth = isPortrait ? size.width * 0.40 : size.width * 0.25;
  final double? cardHeight = isPortrait ? size.height * 0.38 : null;

  return InkWell(
    onTap:onTap,
    child: Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.006,
        horizontal: isPortrait ? 0 : size.width * 0.01,
      ),
      padding: EdgeInsets.all(isPortrait ? size.width * 0.015 : size.width * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(responsiveRef * 0.02),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: responsiveRef * 0.005,
              offset: Offset(0, responsiveRef * 0.002)
          ),
        ],
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================== الصورة ==================
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: isPortrait ? size.height * 0.12 : size.height * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(responsiveRef * 0.02),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.006,
                right: size.width * 0.012,
                child: CircleAvatar(
                  radius: isPortrait ? size.width * 0.035 : size.width * 0.022,
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: isPortrait ? size.width * 0.04 : size.width * 0.025,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.006),

          // ================== التاغات ==================
          Wrap(
            spacing: size.width * 0.01,
            runSpacing: size.height * 0.002,
            children: [
              _buildResponsiveTag(eventType, isPortrait, size, responsiveRef),
              _buildResponsiveTag(provider, isPortrait, size, responsiveRef),
            ],
          ),

          SizedBox(height: isPortrait ? size.height * 0.008 : size.height * 0.01),

          // ================== النصوص ==================
          Text(
            serviceName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isPortrait ? size.width * 0.035 : size.width * 0.022,
              color: dark,
              fontWeight: FontWeight.bold,
              fontFamily: 'BahijTheSansArabic',
            ),
          ),

          SizedBox(height: size.height * 0.004),

          Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isPortrait ? size.width * 0.028 : size.width * 0.018,
              color: Colors.grey[700],
              fontFamily: 'BahijTheSansArabic',
            ),
          ),

          SizedBox(height: isPortrait ? size.height * 0.012 : size.height * 0.01),

          // ================== المدة والسعر ==================
          Row(
            children: [
              Icon(Icons.watch_later_outlined,
                  size: isPortrait ? size.width * 0.035 : size.width * 0.02,
                  color: Colors.grey[800]),
              SizedBox(width: size.width * 0.01),
              Expanded(
                child: Text(
                  duration,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: isPortrait ? size.width * 0.028 : size.width * 0.018,
                      color: dark
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.005),

          Row(
            children: [
              Text("السعر: ",
                  style: TextStyle(
                      fontSize: isPortrait ? size.width * 0.028 : size.width * 0.018,
                      color: dark
                  )
              ),
              Text(
                priceAfterDiscount != null ? "$priceAfterDiscount S.P" : "$priceBeforeDiscount S.P",
                style: TextStyle(
                  fontSize: isPortrait ? size.width * 0.03 : size.width * 0.02,
                  color: orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: isPortrait ? size.height * 0.01 : size.height * 0.015),

          Center(child: SmallIntroButton(title: 'إضافة')),
        ],
      ),
    ),
  );
}

// تعديل ويدجت التاغات لتعتمد على النسب أيضاً
Widget _buildResponsiveTag(String text, bool isPortrait, Size size, double ref) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.015,
        vertical: size.height * 0.002
    ),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(ref * 0.01),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: isPortrait ? size.width * 0.025 : size.width * 0.016,
        color: Colors.black87,
      ),
    ),
  );
}

/////////////search bar
Widget SearchBar({required BuildContext context, required Function(String) onChanged}) {
  final size = MediaQuery.of(context).size;
  final bool isLandscape = size.width > size.height;

  // نستخدم أصغر ضلع كمرجع للنسب المئوية للأحجام الثابتة بصرياً
  final ref = size.shortestSide;

  return Row(
    children: [
      // أيقونة الفلتر تأخذ نسبة من أصغر ضلع لتبقى مربعة ومتناسبة
      FilterIcon(onTap: () {}),

      // مسافة أفقية بنسبة 2% من عرض الشاشة
      SizedBox(width: size.width * 0.02),

      // السيرش بار يأخذ المساحة المتبقية تلقائياً (Responsive)
      Expanded(
        child: Container(
          // الارتفاع بنسبة 12% من أصغر ضلع لضمان تناسقه في الروتيت
          height: ref * 0.12,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            // حواف دائرية بنسبة 2% من أصغر ضلع
            borderRadius: BorderRadius.circular(ref * 0.02),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.search,
                color: Colors.grey[600],
                // حجم الأيقونة 5% من أصغر ضلع
                size: ref * 0.055,
              ),
              SizedBox(width: size.width * 0.02),

              Expanded(
                child: TextField(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  onChanged: onChanged,
                  style: TextStyle(
                    // الخط بنسبة 4% من أصغر ضلع
                    fontSize: ref * 0.045,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BahijTheSansArabic',
                  ),
                  decoration: InputDecoration(
                    hintText: 'ابحث هنا عن خدمة',
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintStyle: TextStyle(
                      fontSize: ref * 0.038,
                      color: Colors.grey[400],
                      fontFamily: 'BahijTheSansArabic',
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
Widget FilterIcon({required VoidCallback onTap, Color? bgColor, Color? iconColor}) {
  return Builder(
      builder: (context) {
        final ref = MediaQuery.of(context).size.shortestSide;
        // حجم البوكس 12% من أصغر ضلع ليبقى مربعاً في الروتيت
        final boxSize = ref * 0.12;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
              color: bgColor ?? Colors.grey[200],
              borderRadius: BorderRadius.circular(ref * 0.02),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              // بادينج داخلي بنسبة 2.5% من حجم البوكس ليبقى اللوغو متناسق
              padding: EdgeInsets.all(boxSize * 0.25),
              child: Image.asset(
                "assets/ic_filter.webp",
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      }
  );
}
///////////////////////////discount bar/fav
Widget FavCheck({required bool Fav}){
  return Container();}
//////////Description card
Widget DescriptionCard({required String description}){
  return Container(
    width:353,
    height:183,
    child:Directionality(
      textDirection:TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment:Alignment.topRight,
                child: IntroText(title:"الوصف", color: dark)),
            SizedBox(height:5,),
            Align(
                alignment:Alignment.topRight,
                child: IntroSecondText(subtitle:description, color:Colors.grey[400]!, size:14))
          ],
        ),
      ),
    ),
  );
}
Widget UserComment({
  required BuildContext context, // أضفنا الـ context هنا لجلب القياسات
  required String userName,
  required String userImage,
  required int rating,
  required String comment,
}) {
  final size = MediaQuery.of(context).size;
  final bool isLandscape = size.width > size.height;

  final ref = size.shortestSide;

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      // بادينج بنسبة 3% من أصغر ضلع
      padding: EdgeInsets.all(ref * 0.03),
      margin: EdgeInsets.symmetric(vertical: ref * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ref * 0.03),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // البدء من اليمين (RTL)
        children: [
          // الجزء العلوي: الصورة + الاسم + التقييم
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // صورة المستخدم متجاوبة
              CircleAvatar(
                radius: ref * 0.07, // نسبة من أصغر ضلع لتبقى دائرية ومتناسقة
                backgroundImage: NetworkImage(userImage),
              ),

              SizedBox(width: size.width * 0.03),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم المستخدم
                    IntroSecondText(
                      subtitle: userName,
                      color: dark,
                      size: ref * 0.045, // حجم الخط نسبة مئوية
                    ),

                    SizedBox(height: ref * 0.01),

                    // النجوم
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: ref * 0.05, // حجم النجمة نسبة مئوية
                        );
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),

          // مسافة رأسية متجاوبة
          SizedBox(height: ref * 0.03),

          // نص التعليق
          IntroSecondText(
            subtitle: comment,
            color: dark,
            size: ref * 0.038, // حجم الخط نسبة مئوية
          )
        ],
      ),
    ),
  );
}

///////////////////////////home of service
Widget DiscountCard({
  required double discount,
  required BuildContext context,
}) {
  final w = MediaQuery.of(context).size.width;
  final h = MediaQuery.of(context).size.height;
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      width: w * (353 / 375),
      // ثبتنا الارتفاع في الروتيت ليعطي مساحة كافية
      height: isLandscape ? 150.0 : h * (140 / 812),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: AssetImage('assets/cover.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: isLandscape ? 8 : h * (20 / 812),
                    left: w * (8 / 375),
                    right: w * (8 / 375),
                  ),
                  // 🔥 الحل هنا: FittedBox يمنع الـ Overflow مهما كان حجم النص
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // يصغر المحتوى فقط إذا تجاوز الحدود
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IntroSecondText(
                          subtitle: 'أحصل على حسم',
                          color: Colors.white,
                          size: isLandscape ? 14 : w * (18 / 375),
                          ellipsis: true,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntroSecondText(
                              subtitle: '${discount.toInt()}%',
                              color: Colors.white,
                              size: isLandscape ? 22 : w * (30 / 375),
                            ),
                            const SizedBox(width: 5),
                            IntroSecondText(
                              subtitle: 'لقاعتك الملكية',
                              color: Colors.white,
                              size: isLandscape ? 14 : w * (18 / 375),
                              ellipsis: true,
                            ),
                          ],
                        ),
                        SizedBox(height: isLandscape ? 8 : h * (5 / 812)),
                        allStickerButton(),
                      ],
                    ),
                  ),
                ),
              ),

              /// 🟠 Sticker
              Padding(
                padding: EdgeInsets.only(
                  bottom: isLandscape ? 0 : h * (60 / 812),
                  right: 10,
                ),
                child: Align(
                  alignment: isLandscape ? Alignment.center : Alignment.bottomCenter,
                  child: Sticker(
                    discount: discount,
                    context: context,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
Widget Sticker({
  required double discount,
  required BuildContext context,
}) {
  final w = MediaQuery.of(context).size.width;
  final h = MediaQuery.of(context).size.height;
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  // في الوضع الأفقي، نستخدم أبعاداً ثابتة أصغر
  final double stickerWidth = isLandscape ? 70 : w * (76 / 375);
  final double stickerHeight = isLandscape ? 28 : h * (28 / 812);
  final double fontSize = isLandscape ? 12 : w * (12 / 375);

  return Container(
    width: stickerWidth,
    height: stickerHeight,
    padding: EdgeInsets.symmetric(
      horizontal: isLandscape ? 6 : w * (6 / 375),
      vertical: isLandscape ? 3 : h * (3 / 812),
    ),
    decoration: const BoxDecoration(
      color: orange,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    child: Center(
      child: IntroSecondText(
        subtitle: 'حسم ${discount.toInt()}%',
        color: light,
        size: fontSize,
        ellipsis: true,
      ),
    ),
  );
}
Widget FilterCard({
  required String image,
  required String type,
  required BuildContext context,
}) {
  final orientation = MediaQuery.of(context).orientation;
  final isLandscape = orientation == Orientation.landscape;
  final w = MediaQuery.of(context).size.width;

  final double cardWidth = isLandscape ? (w * 0.12).clamp(80.0, 110.0) : w * (90 / 375);

  // استخدمنا Material هنا ليعمل تأثير الـ InkWell بشكل صحيح فوق الخلفية البيضاء
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        // الانتقال إلى صفحة Todolist1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Todolist1(eventName: 'wedding', remainingDays:4,)),
        );
      },
      borderRadius: BorderRadius.circular(12), // لضمان أن تأثير النقر لا يخرج عن الحواف
      child: Container(
        width: cardWidth,
        height: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // أضفت ظل خفيف ليعطي شكل الكارد الحقيقي
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(cardWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: cardWidth * 0.45,
                height: cardWidth * 0.45,
              ),
              SizedBox(height: cardWidth * 0.08),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: IntroSecondText(
                  subtitle: type,
                  color: dark,
                  size: cardWidth * 0.15,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
Widget LeftSticker({required double discount}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight;

      return Container(
        width: w == double.infinity ? 76 : w,
        height: h == double.infinity ? 28 : h,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: const BoxDecoration(
          color: orange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: IntroSecondText(
            subtitle: '${discount}% حسم',
            color: light,
            size: 14,
          ),
        ),
      );
    },
  );
}


Widget ServiceProviderCardPhoto({
  required String imageUrl,
  required String name,
  required double rating,
  required double discount,
  required BuildContext context, // أضفنا context هنا للتمكن من التنقل
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final orientation = MediaQuery.of(context).orientation;
      final isLandscape = orientation == Orientation.landscape;

      final cardWidth = isLandscape
          ? (screenWidth * 0.25).clamp(140.0, 180.0)
          : screenWidth * 0.4;

      final cardHeight = cardWidth * (180 / 150);

      return Material(
        color: Colors.transparent, // لجعل الخلفية شفافة
        child: InkWell(
          onTap: () {
            // الانتقال إلى صفحة Servicesproviderhome
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Servicesproviderhome()),
            );
          },
          borderRadius: BorderRadius.circular(cardWidth * 0.08),
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardWidth * 0.08),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cardWidth * 0.08),
              child: Stack(
                children: [
                  Positioned.fill(child: Image.network(imageUrl, fit: BoxFit.cover)),
                  // الطبقة الداكنة السفلية مع النصوص
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: cardHeight * 0.38,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: cardWidth * 0.08,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: cardWidth * 0.08),
                              const SizedBox(width: 4),
                              Text(
                                rating.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: cardWidth * 0.07),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // الملصق (Sticker) فوق كل شيء
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Transform.scale(
                      scale: isLandscape ? 0.8 : 1.0,
                      child: LeftSticker(discount: discount),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
Widget TrendCard({
  required String imageUrl,
  required String title,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final orientation = MediaQuery.of(context).orientation;
      final isLandscape = orientation == Orientation.landscape;

      // العرض في الروتيت لا يتجاوز 250 بكسل
      final cardWidth = isLandscape
          ? (screenWidth * 0.4).clamp(200.0, 250.0)
          : screenWidth * 0.65;

      final cardHeight = cardWidth * (95 / 195);

      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // قسم الصورة
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              // قسم النصوص
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(color: dark, fontSize: cardWidth * 0.07, fontWeight: FontWeight.bold),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      Row(
                        children: [
                          Text("تفاصيل", style: TextStyle(color: Colors.grey, fontSize: cardWidth * 0.05)),
                          Icon(Icons.arrow_right_sharp, color: purple, size: cardWidth * 0.1),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
Widget TrendCardPage({
  required String imageUrl,
  required String title,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // نستخدم العرض المتاح (سواء كان عرض الشاشة أو العرض المحدد من الأب)
      final cardWidth = constraints.maxWidth;

      // تعديل النسبة لجعل الكارد "أنحف" (تقليل الارتفاع)
      // بدل 88/195 جربنا 75/200 لتصغير الحجم الكلي
      final cardHeight = cardWidth * (70 / 200);

      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12), // رقم ثابت للنعومة بدل النسب الكبيرة
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // ===== الصورة (صغرنا عرضها من 45% لـ 38%) =====
              SizedBox(
                width: cardWidth * 0.38,
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // بادينغ ثابت أريح للعين
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/cover.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // ===== النصوص =====
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // توزيع متناسق
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          // صغرنا حجم الخط من 0.07 لـ 0.05
                          fontSize: cardWidth * 0.055,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BahijTheSansArabic',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // صف "التفاصيل"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "تفاصيل",
                            style: TextStyle(
                              color: Colors.grey,
                              // صغرنا حجم نص التفاصيل
                              fontSize: cardWidth * 0.04,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            // صغرنا الأيقونة
                            size: cardWidth * 0.06,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
////////////////////BirthdayHome
Widget SearchBarHome({required BuildContext context, required Function(String) onChanged}) {
  final w = MediaQuery.of(context).size.width;
  final h = MediaQuery.of(context).size.height;

  return Row(
    mainAxisAlignment:MainAxisAlignment.spaceBetween,
    children:[
      Container(
        width: w * (320/ 375),
        height: h * (45 / 812),
        padding: EdgeInsets.symmetric(horizontal: w * (10 / 375)),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(w * (4/ 375)),
        ),
        child: Row(
          textDirection: TextDirection.rtl, // الأيقونة على اليمين
          children: [
            Icon(
              Icons.search,
              color: Colors.grey[600],
              size: w * (20 / 375),
            ),
            SizedBox(width: w * (8 / 375)),

            // TextField
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  textAlign:TextAlign.right,// الكتابة من اليمين لليسار
                  onChanged: onChanged,
                  style: TextStyle(
                    fontSize: w * (16 / 375),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold, // ليكون أكبر بوشي
                    fontFamily: 'BahijTheSansArabic',
                  ),
                  decoration: InputDecoration(
                    hintText: 'ابحث هنا عن خدمة',
                    hintStyle: TextStyle(
                      fontSize: w * (14 / 375),
                      color: Colors.grey[400],
                      fontFamily: 'BahijTheSansArabic',
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
Widget outSearchBarHome({
  required BuildContext context,
  required Function(String) onChanged,
}) {
  // 1. الحصول على حجم الشاشة
  final size = MediaQuery.of(context).size;

  // 2. الحصول على الاتجاه (Orientation) بشكل صحيح من MediaQuery مباشرة
  final orientation = MediaQuery.of(context).orientation;
  final bool isPortrait = orientation == Orientation.portrait;

  return Container(
    // نستخدم isPortrait الآن بدون أخطاء
    height: isPortrait ? size.height * (45 / 812) : 42,
    padding: EdgeInsets.symmetric(horizontal: isPortrait ? size.width * (10 / 375) : 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(isPortrait ? size.width * (4 / 375) : 6),
      border: Border.all(
        color: Colors.grey[400]!,
        width: 1,
      ),
    ),
    child: Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.search,
          color: Colors.grey[600],
          size: isPortrait ? size.width * (20 / 375) : 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            textDirection: TextDirection.rtl,
            textAlignVertical: TextAlignVertical.center,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: isPortrait ? size.width * (16 / 375) : 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontFamily: 'BahijTheSansArabic',
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.zero,
              hintText: 'ابحث هنا عن خدمة',
              hintStyle: TextStyle(
                fontSize: isPortrait ? size.width * (14 / 375) : 12,
                color: Colors.grey[400],
                fontFamily: 'BahijTheSansArabic',
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
Widget BirthdayHomeCardFilter({
  required BuildContext context,
  required String title,
  required String icon,
  required GestureTapCallback onPressed,
}) {
  final size = MediaQuery.of(context).size;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  // استخدام shortestSide يضمن عدم انفجار الأحجام عند تدوير الشاشة
  final double reference = size.shortestSide;

  // تعديل القيم لتكون ثابتة أكثر في الروتيت لتجنب الـ Overflow
  final double horizontalPadding = isPortrait ? 12 : reference * 0.03;
  final double verticalPadding = isPortrait ? 6 : reference * 0.015; // تقليل البادينغ العمودي
  final double fontSize = isPortrait ? 14 : reference * 0.035;
  final double iconSize = isPortrait ? 20 : reference * 0.05;
  final double spacing = isPortrait ? 3 : reference * 0.015;

  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(isPortrait ? 4 : 6),
        border: Border.all(
          color: Colors.black,
          width: isPortrait ? 1 : 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // مهم جداً لعدم أخذ عرض الشاشة كاملاً
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // النص
          Text(
            title,
            style: TextStyle(
              color: Colors.black, // تأكد من استخدام dark إذا كان معرفاً
              fontSize: fontSize,
              fontFamily: 'BahijTheSansArabic',
            ),
          ),

          SizedBox(width: spacing),

          // الأيقونة
          Image.asset(
            icon,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          )
        ],
      ),
    ),
  );
}

Widget BirthdayFilterCard({
  required String image,
  required String type,
  required BuildContext context,
}) {
  final size = MediaQuery.of(context).size;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  // البعد الأصغر للشاشة هو المرجع لضمان عدم "انفجار" الأحجام في الروتيت
  final double reference = size.shortestSide;

  // حساب الأبعاد بناءً على الاتجاه
  // في الروتيت نزيد العرض قليلاً ليتناسب مع شكل الفلتر
  final double cardWidth = isPortrait ? reference * 0.14 : reference * 0.18;
  // في الروتيت لا نعتمد على ارتفاع الشاشة بل على نسبة من العرض المرجعي
  final double cardHeight = isPortrait ? size.height * 0.075 : reference * 0.20;

  return Container(
    width: cardWidth,
    height: cardHeight,
    decoration: BoxDecoration(
      color: light, // تأكد من تعريف متغير light
      borderRadius: BorderRadius.circular(isPortrait ? 12 : 8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(reference * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الصورة
          Flexible(
            child: Image.asset(
              image,
              width: isPortrait ? reference * 0.07 : reference * 0.09,
              height: isPortrait ? reference * 0.07 : reference * 0.09,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: isPortrait ? 4 : 2),

          // النص
          Flexible(
            child: FittedBox( // لضمان عدم خروج النص عن حدود الكارد
              fit: BoxFit.scaleDown,
              child: IntroSecondText(
                subtitle: type,
                color: dark,
                size: isPortrait ? reference * 0.032 : reference * 0.038,
              ),
            ),
          ),
        ],
      ),
    ),
  );

}
////////////////////////

