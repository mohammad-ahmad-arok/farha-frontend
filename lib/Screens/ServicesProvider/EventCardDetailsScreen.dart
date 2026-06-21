import 'dart:ffi' as ffi;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class EventCardDetails extends StatefulWidget {
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

  const EventCardDetails({
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
  State<EventCardDetails> createState() => _EventCardDetailsState();
}

class _EventCardDetailsState extends State<EventCardDetails> {
  @override
  void initState() {
    super.initState();
    selectedProvider = 'غير محدد';
  }

  @override
  late String selectedProvider;

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_sharp,
              color: dark,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: isPortrait
            ? _buildContent(size, isPortrait) // الوضع الطولي
            : Row( // الوضع العرضي: الصور بجانب النصوص
          children: [
            Expanded(flex: 5, child: _buildImageSection(size, isPortrait)),
            Expanded(flex: 5, child: SingleChildScrollView(child: _buildDetailsSection(size, isPortrait))),
          ],
        ),
      ),
    );
  }

  // --- قسم الصور ---
  Widget _buildImageSection(Size size, bool isPortrait) {
    return SizedBox(
      height: isPortrait ? size.height * 0.25 : size.height * 0.8,
      child: ListView.builder(
        scrollDirection: isPortrait ? Axis.horizontal : Axis.vertical,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: isPortrait ? 0 : size.height * 0.01,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.images[index],
                fit: BoxFit.cover,
                width: isPortrait ? size.width * 0.8 : double.infinity,
                height: isPortrait ? double.infinity : size.height * 0.4,
              ),
            ),
          );
        },
      ),
    );
  }

  // --- قسم التفاصيل ---
  Widget _buildDetailsSection(Size size, bool isPortrait) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IntroText(title: widget.serviceName, color: dark),
          ),
          SizedBox(height: size.height * 0.02),
// استبدلي قسم الـ Row الخاص بالسعر بهذا الكود:
          Align(
            alignment: Alignment.topRight,
            child: Wrap( // استخدمنا Wrap بدلاً من Row لمنع الـ Overflow
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                IntroSecondText(subtitle: "السعر:", color: dark, size: 16),
                SizedBox(width: size.width * 0.02),
                if (widget.priceAfterDiscount != null) ...[
                  IntroSecondText(subtitle: "S.P ${widget.priceAfterDiscount}", color: orange, size: 16),
                  SizedBox(width: size.width * 0.03),
                  Text(
                    "${widget.priceBeforeDiscount} S.P",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: size.width * 0.035, // صغرنا حجم الخط قليلاً للنسبة
                      decoration: TextDecoration.lineThrough,
                      fontFamily: 'BahijTheSansArabic',
                    ),
                  ),
                ] else ...[
                  IntroSecondText(subtitle: "S.P ${widget.priceBeforeDiscount}", color: orange, size: 14),
                ],
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: size.height * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: IntroSecondText(
                  subtitle: widget.description,
                  color: Colors.grey[500]!,
                  size: 16,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: dark,
                      size: size.width * 0.06,
                    ),
                    SizedBox(width: size.width * 0.01),
                    IntroSecondText(subtitle: "مدة التنفيذ : ${widget.duration}", color: dark, size: 16),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
          IntroButton(
            title: "إضافة ➕",
            onPressed: () {
              Get.back(result: widget.provider);
            },
          ),
        ],
      ),
    );
  }

  // تجميع الموبايل (Portrait)
  Widget _buildContent(Size size, bool isPortrait) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageSection(size, isPortrait),
          _buildDetailsSection(size, isPortrait),
        ],
      ),
    );
  }
}