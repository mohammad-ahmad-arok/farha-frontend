import 'package:flutter/material.dart';
import '../../../../Shared/Components/buttons.dart';
import '../../../../Shared/Components/components.dart';
import '../../../../Shared/Style/Colors.dart';
import 'EventPage.dart';
import 'DurationPage.dart';

class FilterBottomSheet extends StatefulWidget {
  final Map<String, bool> initialEventSelections;
  final Map<String, bool> initialDurationSelections;

  const FilterBottomSheet({
    super.key,
    required this.initialEventSelections,
    required this.initialDurationSelections,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Map<String, bool> eventSelections;
  late Map<String, bool> durationSelections;

  @override
  void initState() {
    super.initState();
    eventSelections = Map.from(widget.initialEventSelections);
    durationSelections = Map.from(widget.initialDurationSelections);
  }

  int _selectedCount(Map<String, bool> selections) {
    return selections.values.where((v) => v).length;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double baseUnit = mediaQuery.size.shortestSide;

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.85,
      ),
      // تقليل الـ vertical padding الأساسي للكونتينر ليصبح أرشق
      padding: EdgeInsets.symmetric(horizontal: baseUnit * 0.05, vertical: baseUnit * 0.02),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: baseUnit * 0.02), // مسافة علوية بسيطة

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: baseUnit * 0.045,
                  ),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: baseUnit * 0.02),
                IntroSecondText(
                  subtitle: 'الفلترة',
                  color: dark,
                  size: baseUnit * 0.045,
                ),
              ],
            ),
            Divider(thickness: 1, height: baseUnit * 0.05),

            // Event type option
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: IntroSecondText(
                subtitle: 'المناسبة',
                color: dark,
                size: baseUnit * 0.04,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_selectedCount(eventSelections) > 0)
                    _buildBadge(_selectedCount(eventSelections), baseUnit),
                  SizedBox(width: baseUnit * 0.02),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: baseUnit * 0.035,
                    color: Colors.grey,
                  ),
                ],
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventPage(
                      title: 'نوع المناسبة',
                      options: const [
                        'جميع المناسبات',
                        'زواج',
                        'تخرج',
                        'عيد ميلاد',
                      ],
                      initialSelections: eventSelections,
                    ),
                  ),
                );
                if (result != null && mounted) {
                  setState(() {
                    eventSelections = result;
                  });
                }
              },
            ),

            // Execution duration option
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: IntroSecondText(
                subtitle: 'مدة التنفيذ',
                color: dark,
                size: baseUnit * 0.04,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_selectedCount(durationSelections) > 0)
                    _buildBadge(_selectedCount(durationSelections), baseUnit),
                  SizedBox(width: baseUnit * 0.02),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: baseUnit * 0.035,
                    color: Colors.grey,
                  ),
                ],
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DurationPage(),
                  ),
                );
                if (result != null && mounted) {
                  setState(() {
                    durationSelections = result;
                  });
                }
              },
            ),

            SizedBox(height: baseUnit * 0.04), // مسافة متوسطة قبل الزر

            // Results button
            SizedBox(
              width: double.infinity,
              child: IntroButton(
                title: "إظهار النتائج",
                onPressed: () {
                  Navigator.pop(context, {
                    'event': eventSelections,
                    'duration': durationSelections,
                  });
                },
              ),
            ),

            // التعديل هنا: تقليل الفراغ السفلي ليكون بالحد الأدنى
            SizedBox(
              height: mediaQuery.padding.bottom > 0
                  ? mediaQuery.padding.bottom // مسافة النظام فقط (مثل آيفون)
                  : baseUnit * 0.03, // مسافة بسيطة جداً للأندرويد
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(int count, double baseUnit) {
    return Container(
      padding: EdgeInsets.all(baseUnit * 0.012), // تصغير البادينج قليلاً
      decoration: BoxDecoration(
        color: purple,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Colors.white,
          fontSize: baseUnit * 0.028,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}