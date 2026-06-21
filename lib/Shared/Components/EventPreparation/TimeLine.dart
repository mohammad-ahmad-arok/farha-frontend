import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Style/Colors.dart';
import '../components.dart';

import 'package:flutter/material.dart';

class VerticalTimeline extends StatelessWidget {
  final List<TimelineItem> items;

  const VerticalTimeline({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        // نستخدم MediaQuery هنا فقط لتحديد ما إذا كان الهاتف بوضعية Landscape
        final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

        // حساب القياسات كنسب مئوية من عرض الحاوية
        final circleSize = width * (isLandscape ? 0.03 : 0.045);
        final paddingHorizontal = width * 0.04;
        final contentSpacing = width * 0.03;

        // الارتفاع يتأثر بالوضعية لضمان تناسق الشكل
        final lineHeight = isLandscape ? 100.0 : 120.0;

        return ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = items[index];
            final isLast = index == items.length - 1;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: IntrinsicHeight( // يضمن أن الخط يمتد بجانب الكارد تماماً
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// عمود التايملاين (الدائرة والخط)
                    SizedBox(
                      width: circleSize,
                      child: Column(
                        children: [
                          Container(
                            width: circleSize,
                            height: circleSize,
                            decoration: BoxDecoration(
                              color: item.isCompleted ? purple : Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (!isLast)
                            Expanded( // الـ Expanded هنا تجعل الخط يمتد لنهاية الكارد تلقائياً
                              child: Container(
                                width: width * 0.005, // عرض الخط كنسبة
                                color: item.isCompleted ? purple : Colors.grey.shade300,
                              ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(width: contentSpacing),

                    /// الكارد
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: width * 0.05),
                        padding: EdgeInsets.all(width * 0.035),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.03), // راديوس مرن
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: width * 0.015,
                              offset: Offset(0, width * 0.008),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// الصف العلوي (الاسم والوقت)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: IntroSecondText(
                                    subtitle: item.serviceProviderName,
                                    color: dark,
                                    size: width * (isLandscape ? 0.025 : 0.04),
                                  ),
                                ),
                                IntroSecondText(
                                  subtitle: item.time,
                                  color: orange,
                                  size: width * (isLandscape ? 0.022 : 0.035),
                                ),
                              ],
                            ),

                            SizedBox(height: width * 0.04),

                            /// العنوان والحالة
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: IntroSecondText(
                                    subtitle: item.title,
                                    color: dark,
                                    size: width * (isLandscape ? 0.025 : 0.04),
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                // تأكد أن الميثود statusBadge تأخذ الـ width لضبط قياساتها داخلياً
                                statusBadge(item.status, width, isLandscape),
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
      },
    );
  }
}
Widget statusBadge(String status, double width, bool isLandscape) {
  // ضبط الحواف لتكون مرنة بناءً على عرض الحاوية
  // في وضع Landscape نضرب النسبة بقيمة أصغر لتجنب الضخامة
  final double horizontalPadding = width * (isLandscape ? 0.02 : 0.03);
  final double verticalPadding = width * (isLandscape ? 0.008 : 0.015);
  final double fontSize = width * (isLandscape ? 0.022 : 0.032);
  final double radius = width * 0.05;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
    decoration: BoxDecoration(
      color: purple.withOpacity(0.15),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: IntroSecondText(
      subtitle: status,
      color: purple,
      size: fontSize,
    ),
  );
}

// lib/Models/timeline_item.dart

class TimelineItem {
  final String title;
  final String serviceProviderName;
  final String time;
  final String status;
  final bool isCompleted;

  TimelineItem({
    required this.title,
    required this.serviceProviderName,
    required this.time,
    required this.status,
    required this.isCompleted,
  });
}