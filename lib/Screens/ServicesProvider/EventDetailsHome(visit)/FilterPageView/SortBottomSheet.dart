import 'package:flutter/material.dart';
import '../../../../Shared/Components/buttons.dart';
import '../../../../Shared/Components/components.dart';
import '../../../../Shared/Style/Colors.dart';
import 'Sortpage.dart';

class SortBottomSheet extends StatefulWidget {
  final String? initialSort;

  const SortBottomSheet({super.key, this.initialSort});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  String? selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.initialSort;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // الحل السحري للروتيت: نستخدم shortestSide ليبقى الحجم صغيراً ومتناسقاً
    final double baseUnit = mediaQuery.size.shortestSide;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: baseUnit * 0.05, vertical: baseUnit * 0.04),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView( // لحماية المحتوى في وضع الـ Landscape
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  subtitle: 'الترتيب',
                  color: dark,
                  size: baseUnit * 0.045,
                ),
              ],
            ),
            Divider(thickness: 1, height: baseUnit * 0.06),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: IntroSecondText(
                subtitle: 'ترتيب حسب',
                color: dark,
                size: baseUnit * 0.04,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (selectedSort != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: baseUnit * 0.03,
                        vertical: baseUnit * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.circular(baseUnit * 0.05),
                      ),
                      child: Text(
                        selectedSort!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: baseUnit * 0.028,
                        ),
                      ),
                    ),
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
                    builder: (context) => Sortpage(
                      initialValue: selectedSort,
                    ),
                  ),
                );
                if (result != null && mounted) {
                  setState(() {
                    selectedSort = result as String?;
                  });
                }
              },
            ),

            SizedBox(height: baseUnit * 0.04), // تقليل المسافة بين الزر وما قبله قليلاً

            SizedBox(
              width: double.infinity,
              child: IntroButton(
                title: "إظهار النتائج",
                onPressed: () {
                  Navigator.pop(context, selectedSort);
                },
              ),
            ),

            // تعديل هذه الجزئية لتقليل الفراغ السفلي
            SizedBox(
              height: mediaQuery.padding.bottom > 0
                  ? mediaQuery.padding.bottom // نكتفي بمسافة النظام فقط بدون زيادة
                  : baseUnit * 0.02,        // فراغ بسيط جداً للهواتف التي لا تملك padding سفلي
            ),
          ],
        ),
      ),
    );
  }
}