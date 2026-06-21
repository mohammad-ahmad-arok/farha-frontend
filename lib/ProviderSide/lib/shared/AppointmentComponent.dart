import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';


class CustomGrayPicker extends StatefulWidget {
  final List<String> options;
  final List<Color> dotColors;
  final Function(int) onSelected;

  const CustomGrayPicker({
    Key? key,
    required this.options,
    required this.dotColors,
    required this.onSelected,
  })  : assert(options.length == dotColors.length, "يجب أن يكون عدد الألوان مساوياً لعدد الخيارات"),
        super(key: key);

  @override
  _CustomGrayPickerState createState() => _CustomGrayPickerState();
}

class _CustomGrayPickerState extends State<CustomGrayPicker> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Responsive width: 90% of screen width, max 500 to keep good look on tablets
    final containerWidth = screenWidth * 0.9 > 500 ? 500.0 : screenWidth * 0.9;

    return Container(
      height: 50,
      width: containerWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade600, width: 1),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.options.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onSelected(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[300] : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: widget.dotColors[index],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.options[index],
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontFamily: 'BahijTheSansArabic',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ServiceRequestCard extends StatelessWidget {
  final String userName;
  final String userImage;
  final String serviceType;
  final String location;
  final String time;
  final String date;
  final String status;
  final String? cancelReason;

  const ServiceRequestCard({
    super.key,
    required this.userName,
    required this.userImage,
    required this.serviceType,
    required this.location,
    required this.time,
    required this.date,
    required this.status,
    this.cancelReason,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjust avatar radius based on screen width
    final avatarRadius = screenWidth < 400 ? 20.0 : 25.0;

    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(screenWidth * 0.03), // dynamic margin
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // dynamic padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: NetworkImage(userImage),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth < 400 ? 14 : 16,
                          fontFamily: 'BahijTheSansArabic',
                        ),
                      ),
                      Text(
                        serviceType,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: screenWidth < 400 ? 12 : 14,
                          fontFamily: 'BahijTheSansArabic',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontSize: screenWidth < 400 ? 10 : 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BahijTheSansArabic',
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 25),

            _buildIconInfo(Icons.location_on_outlined, location, screenWidth),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: _buildIconInfo(Icons.access_time, time, screenWidth)),
                Expanded(child: _buildIconInfo(Icons.calendar_month_outlined, date, screenWidth)),
              ],
            ),

            const SizedBox(height: 15),

            _buildActionSection(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text, double screenWidth) {
    return Row(
      children: [
        Icon(icon, size: screenWidth < 400 ? 16 : 18, color: Colors.purple),
        const SizedBox(width: 5),
        IntroSecondText(
          subtitle: text,
          color: dark,
          size: screenWidth < 400 ? 12 : 14,
        ),
      ],
    );
  }

  Widget _buildActionSection(double screenWidth) {
    final roundedShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );

    if (status == "في انتظار التثبيت") {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                shape: roundedShape,
              ),
              child: IntroSecondText(
                subtitle: "تثبيت",
                color: Colors.white,
                size: screenWidth < 400 ? 12 : 14,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: roundedShape,
              ),
              child: IntroSecondText(
                subtitle: "رفض",
                color: Colors.red,
                size: screenWidth < 400 ? 12 : 14,
              ),
            ),
          ),
        ],
      );
    } else if (status == "مثبتة") {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
          label: IntroSecondText(
            subtitle: "تواصل",
            color: Colors.white,
            size: screenWidth < 400 ? 12 : 14,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: roundedShape,
          ),
        ),
      );
    } else if (status == "ملغية") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroSecondText(
            subtitle: "سبب الإلغاء:",
            color: dark,
            size: screenWidth < 400 ? 14 : 16,
          ),
          const SizedBox(height: 4),
          IntroSecondText(
            subtitle: cancelReason ?? "لا يوجد سبب محدد",
            color: dark,
            size: screenWidth < 400 ? 12 : 14,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "في انتظار التثبيت":
        return Colors.orange;
      case "مثبتة":
        return Colors.green;
      case "ملغية":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class CustomMiniCardRow extends StatelessWidget {
  const CustomMiniCardRow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth / 4.2; // Divide screen width into roughly 4 cards
    final cardHeight = screenWidth < 400 ? 70.0 : 80.0;

    final List<Map<String, String>> cardData = [
      {'number': '1', 'title': 'حجوزات اليوم'},
      {'number': '2', 'title': 'حجوزات الغد'},
      {'number': '3', 'title': 'طلبات جديدة'},
      {'number': '4', 'title': 'حجوزات غير مثبتة'},
    ];

    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardData.length,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        itemBuilder: (context, index) {
          return Container(
            width: cardWidth,
            height: cardHeight,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntroSecondText(
                  subtitle: cardData[index]['number']!,
                  color: purple,
                  size: screenWidth < 400 ? 14 : 16,
                ),
                IntroSecondText(
                  subtitle: cardData[index]['title']!,
                  color: purple,
                  size: screenWidth < 400 ? 12 : 14,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}