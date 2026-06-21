import 'package:flutter/material.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  String selectedCategory = 'الكل';
  final List<String> categories = ['الكل', 'العامة', 'حسابي', 'خدمات'];

  final List<Map<String, dynamic>> faqItems = [
    {
      'question': 'كيف يمكنني إنشاء حساب جديد؟',
      'answer': 'يمكنك إنشاء حساب جديد بالنقر على زر "إنشاء حساب" في صفحة تسجيل الدخول، ثم إدخال البيانات المطلوبة مثل الاسم والبريد الإلكتروني وكلمة المرور.',
      'category': 'العامة',
      'isExpanded': false,
    },
    {
      'question': 'كيف يمكنني تغيير كلمة المرور؟',
      'answer': 'نعم، يمكنك تغيير كلمة المرور من خلال الذهاب إلى الملف الشخصي ثم اختيار "تغيير كلمة المرور" وإدخال كلمة المرور الحالية والجديدة.',
      'category': 'حسابي',
      'isExpanded': false,
    },
    {
      'question': 'كيف يمكنني حذف حسابي؟',
      'answer': 'لحذف حسابك، يرجى التواصل مع فريق الدعم الفني عبر البريد الإلكتروني support@example.com وسيقومون بمساعدتك في ذلك.',
      'category': 'حسابي',
      'isExpanded': false,
    },
    {
      'question': 'ما هي طرق الدفع المتاحة؟',
      'answer': 'نقبل العديد من طرق الدفع بما في ذلك بطاقات الائتمان (فيزا، ماستركارد) والدفع عند الاستلام والمحافظ الإلكترونية.',
      'category': 'خدمات',
      'isExpanded': false,
    },
    {
      'question': 'كم تستغرق عملية التوصيل؟',
      'answer': 'تستغرق عملية التوصيل عادة من 3 إلى 5 أيام عمل حسب منطقتك. يمكنك تتبع طلبك من خلال التطبيق.',
      'category': 'خدمات',
      'isExpanded': false,
    },
    {
      'question': 'هل التطبيق مجاني؟',
      'answer': 'نعم، التطبيق مجاني بالكامل للتحميل والاستخدام. قد يتم تطبيق رسوم على بعض الخدمات المميزة.',
      'category': 'العامة',
      'isExpanded': false,
    },
    {
      'question': 'كيف يمكنني تحديث بياناتي الشخصية؟',
      'answer': 'يمكنك تحديث بياناتي الشخصية من خلال الذهاب إلى الملف الشخصي ثم اختيار "تعديل الملف الشخصي" وتحديث المعلومات المطلوبة.',
      'category': 'حسابي',
      'isExpanded': false,
    },
    {
      'question': 'ماذا أفعل إذا نسيت كلمة المرور؟',
      'answer': 'إذا نسيت كلمة المرور، يمكنك النقر على "نسيت كلمة المرور" في صفحة تسجيل الدخول واتباع التعليمات لإعادة تعيينها عبر البريد الإلكتروني.',
      'category': 'حسابي',
      'isExpanded': false,
    },
  ];

  List<Map<String, dynamic>> get filteredFaqItems {
    if (selectedCategory == 'الكل') {
      return faqItems;
    } else {
      return faqItems.where((item) => item['category'] == selectedCategory).toList();
    }
  }

  void toggleExpand(int index) {
    setState(() {
      // إغلاق الباقي وفتح المختار فقط لتجربة مستخدم أفضل
      for (int i = 0; i < filteredFaqItems.length; i++) {
        if (i == index) {
          filteredFaqItems[i]['isExpanded'] = !filteredFaqItems[i]['isExpanded'];
        } else {
          filteredFaqItems[i]['isExpanded'] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarEventDetails(context, "الأسئلة الشائعة", showLeftButton: false),

            SizedBox(height: size.height * 0.02),

            // الفلاتر الأفقية (Categories)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: SizedBox(
                height: size.height * 0.06, // ارتفاع نسبي
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true, // لتبدأ القائمة من اليمين (عربي)
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;

                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = category),
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * 0.02),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? purple : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? purple : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 15, // مكبر قليلاً
                              color: isSelected ? Colors.white : Colors.grey.shade600,
                              fontFamily: 'BahijTheSansArabic',
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // قائمة الأسئلة
            Expanded(
              child: filteredFaqItems.isEmpty
                  ? _buildEmptyState(size)
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                physics: const BouncingScrollPhysics(),
                itemCount: filteredFaqItems.length,
                itemBuilder: (context, index) {
                  final item = filteredFaqItems[index];
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isLandscape ? 850 : 550),
                      child: Container(
                        margin: EdgeInsets.only(bottom: size.height * 0.015),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            // السؤال
                            GestureDetector(
                              onTap: () => toggleExpand(index),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04,
                                  vertical: size.height * 0.02,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      item['isExpanded']
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: purple,
                                      size: 26,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        item['question'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87,
                                          fontFamily: 'BahijTheSansArabic',
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // الجواب
                            if (item['isExpanded'])
                              Padding(
                                padding: EdgeInsets.only(
                                  right: size.width * 0.04,
                                  left: size.width * 0.04,
                                  bottom: size.height * 0.02,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item['answer'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                      fontFamily: 'BahijTheSansArabic',
                                      height: 1.6,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(Size size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.help_outline,
            size: size.width * 0.2,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            'لا توجد أسئلة في هذه الفئة',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
              fontFamily: 'BahijTheSansArabic',
            ),
          ),
        ],
      ),
    );
  }
}