import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/bookingController.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import 'Booking.dart';

class EventCardDetailsBooking extends StatefulWidget {
  final String imageUrl;
  final String serviceName;
  final String description;
  final String duration;
  final double priceBeforeDiscount;
  final double? priceAfterDiscount;
  final double? discountPercent;
  final bool isFavorite;
  final String category;
  final String provider;
  final String specificType;
  final String eventType;
  final List<String> images;

  const EventCardDetailsBooking({
    super.key,
    required this.imageUrl,
    required this.serviceName,
    required this.description,
    required this.duration,
    required this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.discountPercent,
    this.isFavorite = false,
    required this.category,
    required this.provider,
    required this.specificType,
    required this.eventType,
    required this.images,
  });

  @override
  State<EventCardDetailsBooking> createState() => _EventCardDetailsBookingState();
}

class _EventCardDetailsBookingState extends State<EventCardDetailsBooking> {
  final EventController controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final double baseUnit = size.shortestSide;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: IntroSecondText(subtitle: widget.category, color: dark, size: baseUnit * 0.045),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: dark, size: baseUnit * 0.05),
          onPressed: () => Get.back(),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: isLandscape
            ? _buildLandscapeLayout(size, baseUnit)
            : _buildPortraitLayout(size, baseUnit),
      ),
    );
  }

  // ================== واجهة وضع الـ Landscape (توزيع 35% صور : 65% تفاصيل) ==================
  Widget _buildLandscapeLayout(Size size, double baseUnit) {
    return Row(
      children: [
        Expanded(
          flex: 35, // مساحة أقل للصور لمنع الضخامة
          child: _buildImageGallery(size, isLandscape: true),
        ),
        Expanded(
          flex: 65, // مساحة أكبر للمحتوى
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.02,
            ),
            child: _buildDetailsContent(size, baseUnit, isLandscape: true),
          ),
        ),
      ],
    );
  }

  // ================== واجهة وضع الـ Portrait (سكرول طولي) ==================
  Widget _buildPortraitLayout(Size size, double baseUnit) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageGallery(size, isLandscape: false),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            child: _buildDetailsContent(size, baseUnit, isLandscape: false),
          ),
        ],
      ),
    );
  }

  // ميثود الصور مع التحكم في الحجم ليكون متناسقاً
  Widget _buildImageGallery(Size size, {required bool isLandscape}) {
    return SizedBox(
      height: isLandscape ? size.height : size.height * 0.32,
      child: ListView.builder(
        scrollDirection: isLandscape ? Axis.vertical : Axis.horizontal,
        itemCount: widget.images.length,
        padding: EdgeInsets.all(size.width * 0.015),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size.width * 0.025),
              child: Image.network(
                widget.images[index],
                fit: BoxFit.cover,
                width: isLandscape ? double.infinity : size.width * 0.82,
                height: isLandscape ? size.height * 0.45 : double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }

  // ميثود التفاصيل مع ضبط الخطوط والمسافات بالنسب المئوية
  Widget _buildDetailsContent(Size size, double baseUnit, {required bool isLandscape}) {
    // خطوط أصغر في الروتيت لتوفير مساحة
    final double resFontSize = isLandscape ? baseUnit * 0.038 : baseUnit * 0.042;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: IntroText(title: widget.serviceName, color: dark)),
            Icon(widget.isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: baseUnit * 0.06),
          ],
        ),
        SizedBox(height: size.height * 0.015),

        // السعر
        Row(
          children: [
            IntroSecondText(subtitle: "السعر:", color: dark, size: resFontSize),
            SizedBox(width: size.width * 0.02),
            if (widget.priceAfterDiscount != null) ...[
              IntroSecondText(subtitle: "S.P ${widget.priceAfterDiscount}", color: orange, size: resFontSize + 4),
              SizedBox(width: size.width * 0.02),
              Text(
                "${widget.priceBeforeDiscount} S.P",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: resFontSize - 2,
                  decoration: TextDecoration.lineThrough,
                  fontFamily: 'BahijTheSansArabic',
                ),
              ),
            ] else ...[
              IntroSecondText(subtitle: "S.P ${widget.priceBeforeDiscount}", color: orange, size: resFontSize + 4),
            ],
          ],
        ),

        const Divider(height: 30, thickness: 0.8),

        IntroSecondText(
          subtitle: widget.description,
          color: Colors.grey[700]!,
          size: resFontSize,
        ),

        SizedBox(height: size.height * 0.03),

        _buildInfoRow(Icons.watch_later_outlined, "مدة التنفيذ:", widget.duration, baseUnit, size, isLandscape),
        SizedBox(height: size.height * 0.015),
        _buildInfoRow(Icons.category_outlined, "النوع:", widget.specificType, baseUnit, size, isLandscape),

        // المسافة قبل الزر
        SizedBox(height: isLandscape ? size.height * 0.06 : size.height * 0.05),

        // الزر بارتفاع ثابت في الروتيت لضمان الرؤية
        SizedBox(
          width: double.infinity,
          height: isLandscape ? 48.0 : size.height * 0.065,
          child: BigIntroButton(
            title: "احجز موعد الآن",
            onPressed: () {
              controller.updateServiceInfo(
                name: widget.serviceName,
                p: widget.priceAfterDiscount ?? widget.priceBeforeDiscount,
                id: 101,
              );
              Get.to(() => CalendarPage());
            },
          ),
        ),
        // بادينغ إضافي للروتيت
        if (isLandscape) SizedBox(height: size.height * 0.05),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, double baseUnit, Size size, bool isLandscape) {
    return Row(
      children: [
        Icon(icon, color: purple, size: isLandscape ? 20 : baseUnit * 0.055),
        SizedBox(width: size.width * 0.02),
        IntroSecondText(
            subtitle: "$label $value",
            color: dark,
            size: isLandscape ? baseUnit * 0.035 : baseUnit * 0.04
        ),
      ],
    );
  }
}