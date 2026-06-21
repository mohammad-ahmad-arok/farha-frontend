import 'package:flutter/material.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  String? selectedProblemType;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final List<String> problemTypes = [
    'مشكلة في تسجيل الدخول',
    'مشكلة في الدفع',
    'مشكلة في التوصيل',
    'استفسار عن خدمة',
    'اقتراح',
    'شكوى',
    'مشكلة تقنية',
    'استفسار عام',
  ];

  // ==================== بناء العناصر (UI Components) ====================

  Widget labelTextRTL(String label) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16, // مكبر قليلاً للوضوح
          color: Colors.black,
          fontFamily: 'BahijTheSansArabic',
          fontWeight: FontWeight.w600,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget customDropdownButtonRTL({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required String hint,
    required Size size,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              hint,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 15, fontFamily: 'BahijTheSansArabic'),
              textDirection: TextDirection.rtl,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(Icons.keyboard_arrow_down, color: purple, size: 26),
          ),
          borderRadius: BorderRadius.circular(8),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 15, color: Colors.black87, fontFamily: 'BahijTheSansArabic'),
                  textDirection: TextDirection.rtl,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget inputFieldRTL({
    required String hint,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required Size size,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'BahijTheSansArabic'),
        decoration: InputDecoration(
          hintText: hint,
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400, fontFamily: 'BahijTheSansArabic'),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.018),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // الزر لا يصعد فوق الكيبورد
      body: SafeArea(
        child: Column(
          children: [
            AppBarEventDetails(context, "تواصل معنا", showLeftButton: false),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isLandscape ? 850 : 550),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.03),

                          // الصورة الشخصية
                          Container(
                            width: (size.width * 0.40).clamp(120.0, 160.0),
                            height: (size.width * 0.40).clamp(120.0, 160.0),
                            decoration: BoxDecoration(
                              color: purple.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("assets/amico.webp", fit: BoxFit.contain),
                            ),
                          ),

                          SizedBox(height: size.height * 0.03),

                          Text(
                            'هل تواجه مشكلة أو صعوبة؟',
                            style: TextStyle(
                              fontSize: isLandscape ? 22 : 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'BahijTheSansArabic',
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: size.height * 0.01),

                          Text(
                            'تواصل مع الدعم الفني الآن',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: 'BahijTheSansArabic',
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: size.height * 0.05),

                          // دروب داون نوع المشكلة
                          labelTextRTL('نوع المشكلة'),
                          SizedBox(height: size.height * 0.008),
                          customDropdownButtonRTL(
                            size: size,
                            value: selectedProblemType,
                            items: problemTypes,
                            hint: 'اختر نوع المشكلة',
                            onChanged: (newValue) => setState(() => selectedProblemType = newValue),
                          ),

                          SizedBox(height: size.height * 0.035),

                          // حقل سبب المشكلة
                          labelTextRTL('سبب المشكلة'),
                          SizedBox(height: size.height * 0.008),
                          inputFieldRTL(
                            size: size,
                            hint: 'اكتب سبب المشكلة بالتفصيل',
                            controller: _reasonController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                          ),

                          SizedBox(height: size.height * 0.035),

                          // حقل رقم الهاتف
                          labelTextRTL('رقم الهاتف'),
                          SizedBox(height: size.height * 0.008),
                          inputFieldRTL(
                            size: size,
                            hint: 'أدخل رقم الهاتف للتواصل',
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(height: size.height * 0.1), // مساحة للسكرول
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // تثبيت الزر في الأسفل
      bottomNavigationBar: bottomBarEventDetails(
        context,
        title: "إرسال",
        onPressed: _submitRequest,
      ),
    );
  }

  // ==================== المنطق (Logic) ====================

  void _submitRequest() {
    if (selectedProblemType == null || _reasonController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(selectedProblemType == null ? 'الرجاء اختيار نوع المشكلة' : 'الرجاء ملء كافة البيانات'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم إرسال استفسارك بنجاح، سنتواصل معك قريباً'),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}