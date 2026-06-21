import 'package:flutter/material.dart';

import '../../../Shared/Style/Colors.dart';
import 'components.dart';
///////////////////////2
///////////////card1
class PriceCard extends StatefulWidget {
  const PriceCard({Key? key}) : super(key: key);

  @override
  _PriceCardState createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  // متغير لحفظ حالة الـ Radio Button
  int _selectedPriceType = 1;
  // متغير لحفظ حالة زر الـ On/Off (Switch)
  bool _isDiscountEnabled = false;
  TextEditingController priController=TextEditingController();
  TextEditingController minpriController=TextEditingController();
  TextEditingController maxpriController=TextEditingController();
  TextEditingController discountPercentController=TextEditingController();
  TextEditingController priceAfterDiscountController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
// غير الارتفاع من 245 إلى قيمة أكبر أو احذفه ليكون مرناً
      height: _isDiscountEnabled ? 300 : 245,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4), // اللون المطلوب
        borderRadius: BorderRadius.circular(8), // الراديوس المطلوبة
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السطر الأول: كلمة الأسعار وجنبها خط
          Row(
            children: [
              const Text(
                "الأسعار",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BahijTheSansArabic',
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey.shade400, // الخط الرمادي
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),


          Row(
            children: [
              // استخدمنا Expanded هنا لحل مشكلة الـ Infinite Width
              Expanded(
                flex: 2, // النص يأخذ مساحة أقل
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.black),
                  child: RadioListTile<int>(
                    value: 1,
                    groupValue: _selectedPriceType,
                    activeColor: Colors.black,
                    title: const Text(
                      "سعر ثابت",
                      style: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: 13),
                    ),
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        _selectedPriceType = value!;
                      });
                    },
                  ),
                ),
              ),
              // حقل الإدخال
              Expanded(
                flex: 2, // الحقل يأخذ المساحة المتبقية
                child: SizedBox(
                  height: 45, // تحديد ارتفاع مناسب للحقل داخل الكارد
                  child: SerInputField(
                    hint: '',
                    controller: priController,
                    keyboradType: TextInputType.number,
                    obscureText: false,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height:15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, // لضمان أن العناصر على خط أفقي واحد من المنتصف
            children: [
              // 1. قسم الراديو بوتون "يبدأ من"
              Expanded(
                flex: 3, // نعطيه مساحة أكبر قليلاً ليحتوي النص والدائرة براحة
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.black),
                  child: RadioListTile<int>(
                    value: 2,
                    groupValue: _selectedPriceType,
                    activeColor: Colors.black,
                    title: const Text(
                      "يبدأ من",
                      style: TextStyle(
                        fontFamily: 'BahijTheSansArabic',
                        fontSize: 13, // صغرنا الخط قليلاً ليناسب العرض الضيق
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        _selectedPriceType = value!;
                      });
                    },
                  ),
                ),
              ),

              // 2. الحقل الأول (السعر الأدنى)
              Expanded(
                flex: 2,
                child: smallSerInputField(
                  hint: '',
                  controller: minpriController,
                  keyboradType: TextInputType.number,
                  obscureText: false,
                ),
              ),

              // 3. كلمة "إلى" في المنتصف
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "إلى",
                    style: TextStyle(
                      fontFamily: 'BahijTheSansArabic',
                      color: Colors.black, // تأكد من استخدام اللون المطلوب هنا
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              // 4. الحقل الثاني (السعر الأعلى)
              Expanded(
                flex: 2,
                child: smallSerInputField(
                  hint: '',
                  controller: maxpriController,
                  keyboradType: TextInputType.number,
                  obscureText: false,
                ),
              ),
            ],
          )  ,
          // داخل الـ Column الرئيسي
// ... الكود السابق (الراديو بوتون والأسعار)

          const Spacer(),

// سطر الـ Switch "مع خصم"
          Row(
            children: [
              const Text(
                "مع خصم",
                style: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: 14),
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _isDiscountEnabled,
                  activeColor: Colors.purple,
                  onChanged: (value) {
                    setState(() {
                      _isDiscountEnabled = value;
                    });
                  },
                ),
              ),
            ],
          ),

// --- الجزء الجديد: يظهر فقط إذا كان الـ Switch مفعلاً ---
          if (_isDiscountEnabled) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                // كلمة "النسبة"
                const Text("النسبة", style: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: 13)),
                const SizedBox(width: 8),

                // حقل النسبة المئوية (نستخدم نسخة معدلة من smallSerInputField)
                Expanded(
                  child: percentageInputField(
                    controller: discountPercentController,
                  ),
                ),

                const SizedBox(width: 12),

                // كلمة "السعر بعده"
                const Text("السعر بعده", style: TextStyle(fontFamily: 'BahijTheSansArabic', fontSize: 13)),
                const SizedBox(width: 8),

                // حقل السعر بعد الخصم (نستخدم smallSerInputField العادي لأنه يحتوي ل.س)
                Expanded(
                  child: smallSerInputField(
                    hint: '',
                    controller: priceAfterDiscountController,
                    keyboradType: TextInputType.number,
                    obscureText: false,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
Widget percentageInputField({
  required TextEditingController controller,
}) {
  return Container(
    height: 42,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        suffixIcon: const Padding(
          padding: EdgeInsets.only(top: 12.0, right: 30),
          child: Text("%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 0.8),
        ),
      ),
    ),
  );
}
Widget SerInputField({
  required String hint,
  required TextEditingController controller,
  required TextInputType keyboradType,
  Widget? icon,
  Function(String)? onChanged, required bool obscureText, // ✅ صار اختياري
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboradType,
    onChanged: onChanged, // ✅ آمن حتى لو null
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.right,
    style: const TextStyle(
      fontSize: 16,
      color: dark,
      fontFamily: 'BahijTheSansArabic',
    ),
    decoration: InputDecoration(
      suffixIcon:Padding(
        padding: const EdgeInsets.only(top: 12.0,
        right:10),
        child: IntroSecondText(subtitle: "ل.س", color:dark, size: 14),
      ),
      focusColor: purple,
      hintText: hint,
      hintTextDirection: TextDirection.rtl,
      hintStyle: const TextStyle(
        fontFamily: 'BahijTheSansArabic',
        color: lightDark,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color:Colors.grey[300]!,
          width: 0.8,
        ),
      ),
    ),
  );
}
Widget smallSerInputField({
  required String hint,
  required TextEditingController controller,
  required TextInputType keyboradType,
  Function(String)? onChanged, required bool obscureText, // ✅ صار اختياري
}) {
  return Container(
    width:100,
    height:42,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboradType,
      onChanged: onChanged, // ✅ آمن حتى لو null
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 16,
        color: dark,
        fontFamily: 'BahijTheSansArabic',
      ),
      decoration: InputDecoration(
        suffixIcon:Padding(
          padding: const EdgeInsets.only(top: 12.0,
          right:17),
          child: IntroSecondText(subtitle: "ل.س", color:dark, size: 12),
        ),
        focusColor: purple,
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
          fontFamily: 'BahijTheSansArabic',
          color: lightDark,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color:Colors.grey[300]!,
            width: 0.8,
          ),
        ),
      ),
    ),
  );
}
class
////////card 2
AppointmentCard extends StatefulWidget {
  const

  AppointmentCard({Key? key}) : super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  int _selectedPriceType = 1;
  bool _isDiscountEnabled = false;
  TextEditingController priController = TextEditingController();
  TextEditingController minpriController = TextEditingController();
  TextEditingController maxpriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      // قمت بإزالة الارتفاع الثابت أو زيادته ليتحمل العناصر الجديدة عند التفعيل
      constraints: const BoxConstraints(minHeight: 245),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ليأخذ الكانتينر حجم محتواه
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السطر العلوي: العنوان والخط
          Row(
            children: [
              const Text(
                "الحجوزات",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BahijTheSansArabic',
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // مدة الإنجاز
          IntroSecondText(subtitle: 'مدة الإنجاز', color: dark, size: 14),
          SizedBox(height:5),
          CustomDropdown(
            label: 'اختر مدة الإنجاز',
            items: ["يوم واحد", "يومان", "أسبوع"],
          ),

          const SizedBox(height: 15),

          // زر التفعيل (يدعم الحجز)
          Row(
            children: [
              const Text(
                "يدعم الحجز",
                style: TextStyle(
                  fontFamily: 'BahijTheSansArabic',
                  fontSize: 14,
                ),
              ),
              const Spacer(), // لدفع السويتش لليسار
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _isDiscountEnabled,
                  activeColor: Colors.purple,
                  onChanged: (value) {
                    setState(() {
                      _isDiscountEnabled = value;
                    });
                  },
                ),
              ),
            ],
          ),

          // --- الجزء الذي يظهر عند التفعيل ---
          if (_isDiscountEnabled) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                // دروب داون الأيام المتاحة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntroSecondText(subtitle: 'الأيام المتاحة', color: dark, size: 13),
                      const SizedBox(width:5),
                      CustomDropdown(
                        label: 'اختر الأيام',
                        items: ["يومياً", "أيام العمل", "نهاية الأسبوع"],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // دروب داون أوقات العمل
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntroSecondText(subtitle: 'أوقات العمل', color: dark, size: 13),
                      const SizedBox(width: 10),
                      CustomDropdown(
                        label: 'اختر الوقت',
                        items: ["صباحي", "مسائي", "فترتين"],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
class CustomDropdown extends StatefulWidget {
  final String label; // e.g., "التصنيف"
  final List<String> items; // list of dropdown options
  final ValueChanged<String?>? onChanged; // callback when selected value changes
  final String? initialValue; // optional initial selected value

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.items,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue ?? (widget.items.isNotEmpty ? widget.items.first : null);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9 > 500 ? 500.0 : screenWidth * 0.9; // responsive

    return Container(
      width: containerWidth,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedValue,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.purple),
          iconSize: 24,
          elevation: 2,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'BahijTheSansArabic',
          ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  // Optional colored dot like in CustomGrayPicker (if needed)
                  // You can uncomment and pass dotColors if desired.
                  // Container(
                  //   width: 8,
                  //   height: 8,
                  //   decoration: BoxDecoration(
                  //     color: _getDotColor(value), // define a method
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                  // const SizedBox(width: 8),
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'BahijTheSansArabic',
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/////////card3
class addtionalCard extends StatefulWidget {
  const addtionalCard({Key? key}) : super(key: key);

  @override
  _addtionalCardState createState() => _addtionalCardState();
}

class _addtionalCardState extends State<addtionalCard> {
  // متغير لحفظ حالة الـ Radio Button
  int _selectedPriceType = 1;
  // متغير لحفظ حالة زر الـ On/Off (Switch)
  bool _isDiscountEnabled = false;
  TextEditingController priController=TextEditingController();
  TextEditingController minpriController=TextEditingController();
  TextEditingController maxpriController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4), // اللون المطلوب
        borderRadius: BorderRadius.circular(8), // الراديوس المطلوبة
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السطر الأول: كلمة الأسعار وجنبها خط
          Row(
            children: [
              const Text(
                "خيارات إضافية",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BahijTheSansArabic',
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey.shade400, // الخط الرمادي
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          IntroSecondText(subtitle: 'الأحجام', color:dark, size:14),
          const SizedBox(width:5),
          CustomDropdown(label: 'اختر الأحجام المتوفرة', items: [
            "hjjb",
            "jkhk",
            "lkjkk"
          ],),
          const SizedBox(height: 15),
          IntroSecondText(subtitle: 'الألوان', color:dark, size:14),
          const SizedBox(width:5),
          CustomDropdown(label: 'أختر الألوان المتوفرة', items: [
            "hjjb",
            "jkhk",
            "lkjkk"
          ],),
          const Spacer(),
          // زر أون أوف (Switch) مع كلمة مع خصم
          Row(
            children: [
              const Text(
                "إتاحة الظهور للعملاء",
                style: TextStyle(
                  fontFamily: 'BahijTheSansArabic',
                  fontSize: 14,
                ),
              ),
              Transform.scale(
                scale: 0.8, // لجعل السويتش "رفيع" أو أصغر قليلاً
                child: Switch(
                  value: _isDiscountEnabled,
                  activeColor: Colors.purple, // أو أي لون تفضله عند التفعيل
                  onChanged: (value) {
                    setState(() {
                      _isDiscountEnabled = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}