import 'package:flutter/material.dart';
import '../../../../Shared/Components/buttons.dart';
import '../../../../Shared/Components/components.dart';
import '../../../../Shared/Style/Colors.dart';

class Sortpage extends StatefulWidget {
  final String? initialValue;
  final Function(String?)? onChanged;

  const Sortpage({super.key, this.initialValue, this.onChanged});

  @override
  State<Sortpage> createState() => _SortpageState();
}

class _SortpageState extends State<Sortpage> {
  final List<String> options = [
    "الأكثر مشاهدة",
    "السعر (من الأقل إلى الأعلى)",
    "السعر (من الأعلى إلى الأقل)",
    "تقييم (من 5 نجوم إلى الأعلى)",
  ];

  late String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // نعتمد على أقصر ضلع لضمان عدم تضخم الراديو والخطوط عند الروتيت
    final double baseUnit = mediaQuery.size.shortestSide;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: IntroSecondText(
          subtitle: "ترتيب حسب",
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
            child: Divider(color: Colors.grey.shade200, thickness: 1),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: baseUnit * 0.04),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final item = options[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedValue = item;
                      widget.onChanged?.call(item);
                    });
                  },
                  child: Container(
                    // تقليص الارتفاع ليكون أرشق
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
                          // تصغير حجم الراديو ليناسب التصميم الجديد
                          scale: baseUnit * 0.0025,
                          child: Radio<String>(
                            activeColor: purple,
                            value: item,
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                widget.onChanged?.call(value);
                              });
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

          Container(
            padding: EdgeInsets.only(
              left: baseUnit * 0.05,
              right: baseUnit * 0.05,
              top: baseUnit * 0.03,
              // تم تعديل القيم هنا لتقليل الفراغ
              bottom: mediaQuery.padding.bottom > 0
                  ? mediaQuery.padding.bottom // نكتفي بمساحة النظام للأجهزة الحديثة
                  : baseUnit * 0.03,          // مساحة بسيطة جداً للأجهزة القديمة
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
                  widget.onChanged?.call(selectedValue);
                  Navigator.pop(context, selectedValue);
                },
              ),
            ),
          ),        ],
      ),
    );
  }
}