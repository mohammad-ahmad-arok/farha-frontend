import 'package:flutter/material.dart';
import '../../../../Shared/Components/buttons.dart';
import '../../../../Shared/Components/components.dart';
import '../../../../Shared/Style/Colors.dart';

class EventPage extends StatefulWidget {
  final Map<String, bool> initialSelections;
  final Function(Map<String, bool>)? onChanged;
  final String title;
  final List<String> options;

  const EventPage({
    super.key,
    this.initialSelections = const {},
    this.onChanged,
    required this.title,
    required this.options,
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late Map<String, bool> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = Map.fromEntries(
      widget.options.map((option) => MapEntry(
        option,
        widget.initialSelections[option] ?? false,
      )),
    );
  }

  void _updateSelection(String key, bool value) {
    setState(() {
      selectedValues[key] = value;
    });
    widget.onChanged?.call(selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // الحل الأساسي: الاعتماد على البعد الأصغر للشاشة لمنع ضخامة العناصر في الروتيت
    final double baseUnit = mediaQuery.size.shortestSide;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: IntroSecondText(
          subtitle: widget.title,
          color: dark,
          size: baseUnit * 0.05,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            size: baseUnit * 0.05,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: baseUnit * 0.04),
            child: Divider(
              color: Colors.grey.shade200,
              thickness: 1,
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: baseUnit * 0.04),
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                final item = widget.options[index];
                return InkWell(
                  onTap: () => _updateSelection(item, !(selectedValues[item] ?? false)),
                  child: Container(
                    // تقليل الارتفاع من 0.15 إلى 0.13 ليكون أرشق في الروتيت
                    height: baseUnit * 0.13,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade100, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.scale(
                          // تصغير حجم الـ Checkbox قليلاً ليناسب التصميم المصغر
                          scale: baseUnit * 0.0025,
                          child: Checkbox(
                            activeColor: purple,
                            value: selectedValues[item],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (bool? value) {
                              _updateSelection(item, value ?? false);
                            },
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IntroSecondText(
                              subtitle: item,
                              color: dark,
                              size: baseUnit * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // منطقة زر التأكيد السفلية المحسنة
          Container(
            padding: EdgeInsets.only(
              left: baseUnit * 0.05,
              right: baseUnit * 0.05,
              top: baseUnit * 0.03,
              bottom: mediaQuery.padding.bottom > 0
                  ? mediaQuery.padding.bottom + 10
                  : baseUnit * 0.05,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: BigIntroButton(
                title: 'تأكيد',
                onPressed: () {
                  widget.onChanged?.call(selectedValues);
                  Navigator.pop(context, selectedValues);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}