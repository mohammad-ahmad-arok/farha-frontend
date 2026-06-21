import 'package:flutter/material.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class EventInformation extends StatefulWidget {
  const EventInformation({super.key});

  @override
  State<EventInformation> createState() => _EventInformationState();
}

class _EventInformationState extends State<EventInformation> {
  final List people = [
    {"user": "Ahmed", "role": "Admin", "image": "https://via.placeholder.com/150"},
    {"user": "Sara", "role": "User", "image": "https://via.placeholder.com/150"},
    {"user": "Ali", "role": "Guest", "image": "https://via.placeholder.com/150"},
    {"user": "Mona", "role": "Admin", "image": "https://via.placeholder.com/150"},
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double baseUnit = mediaQuery.size.shortestSide; // الأفضل للاعتماد عليه في الأحجام
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            // تعديل البادينغ ليكون أصغر في الروتيت
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? screenWidth * 0.02 : screenWidth * 0.04,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // كروت المعلومات
                // نستخدم Wrap أو ListView ليكون الشكل أفضل، لكن سنبقي على الـ Column مع تصغير المسافات
                _buildInfoCard('assets/ring.webp', 'نوع المناسبة', 'زفاف لين واحمد', context, screenHeight, isLandscape),
                _buildInfoCard('assets/star.webp', 'اسم المناسبة', 'زفاف لين واحمد', context, screenHeight, isLandscape),
                _buildInfoCard('assets/date.webp', 'تاريخ المناسبة', 'زفاف لين واحمد', context, screenHeight, isLandscape),
                _buildInfoCard('assets/role.webp', 'دورك في المناسبة', 'العريس', context, screenHeight, isLandscape),

                SizedBox(height: isLandscape ? 10 : screenHeight * 0.02),

                // خط التذكير
                Row(
                  children: [
                    Text('مواعيد التذكير',
                        style: TextStyle(color: dark, fontSize: baseUnit * 0.038, fontWeight: FontWeight.bold)
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    const Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                  ],
                ),

                SizedBox(height: isLandscape ? 8 : screenHeight * 0.02),

                // وضع المواعيد في Row واحد في الروتيت لتوفير المساحة
                isLandscape
                    ? Row(
                  children: [
                    Expanded(child: _buildReminderRow("assets/finish.webp", "إنهاء الترتيبات:", "20/5/2024", baseUnit, screenWidth)),
                    Expanded(child: _buildReminderRow("assets/bell.webp", "وقت التذكير:", "قبل يوم واحد", baseUnit, screenWidth)),
                  ],
                )
                    : Column(
                  children: [
                    _buildReminderRow("assets/finish.webp", "إنهاء الترتيبات:", "20/5/2024", baseUnit, screenWidth),
                    SizedBox(height: screenHeight * 0.015),
                    _buildReminderRow("assets/bell.webp", "وقت التذكير:", "قبل يوم واحد", baseUnit, screenWidth),
                  ],
                ),

                SizedBox(height: screenHeight * 0.03),

                Align(
                  alignment: Alignment.centerRight, // التأكد من المحاذاة لليمين (عربي)
                  child: Text("الأشخاص المعنيين",
                      style: TextStyle(color: dark, fontSize: baseUnit * 0.038, fontWeight: FontWeight.bold)
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isLandscape ? 3 : 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                    // تعديل الـ Ratio ليكون المحتوى مرتاحاً في الروتيت
                    childAspectRatio: isLandscape ? 3.0 : 2.5,
                  ),
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: isLandscape ? 18 : baseUnit * 0.055,
                          backgroundImage: NetworkImage(people[index]["image"]),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                people[index]["user"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: isLandscape ? 12 : baseUnit * 0.035, fontWeight: FontWeight.bold, color: dark),
                              ),
                              Text(
                                people[index]["role"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: isLandscape ? 10 : baseUnit * 0.03, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // تعديل الـ helper ليكون مرناً مع الروتيت
  Widget _buildInfoCard(String img, String title, String info, BuildContext ctx, double h, bool isLandscape) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLandscape ? 6 : h * 0.01),
      child: EventInformationCard(image: img, main: title, info: info, context: ctx),
    );
  }

  Widget _buildReminderRow(String img, String title, String info, double base, double w) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(img, width: base * 0.065),
        const SizedBox(width: 8),
        Text(title, style: TextStyle(color: dark, fontSize: base * 0.032)),
        const SizedBox(width: 5),
        Expanded(
          child: Text(info,
            style: TextStyle(color: Colors.grey, fontSize: base * 0.03),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}