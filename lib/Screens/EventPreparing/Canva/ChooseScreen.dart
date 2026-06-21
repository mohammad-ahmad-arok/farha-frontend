import 'package:flutter/material.dart';
import '../../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../../Shared/Components/ServiceProvider/ServicesProviderComponents.dart';
import '../../../Shared/Style/Colors.dart';
import 'TextControl.dart';

class TemplateScreen extends StatelessWidget {
  TemplateScreen({super.key});

  final List<String> templates = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarEventDetails(context, "اختيار كرت الدعوة"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: outSearchBarHome(
              context: context,
              onChanged: (value) {},
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 1. تحديد اتجاه الشاشة
                final bool isLandscape = constraints.maxWidth > constraints.maxHeight;

                // 2. عدد الأعمدة: في الطول 2، وفي العرض نزيدها لـ 4 لكي لا يعرض الكرت بشكل بشع
                final int crossAxisCount = isLandscape ? 4 : 2;

                // 3. النسبة الذهبية للكرت الطولي (العرض / الطول)
                // اخترنا 0.7 ليظهر الكرت مستطيلاً طويلاً بشكل أنيق
                const double cardAspectRatio = 0.7;

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: templates.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: cardAspectRatio, // هنا نثبت النسبة لتكون طولية دائماً
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditorScreen(
                              imagePath: templates[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            templates[index],
                            // BoxFit.cover يضمن أن الصورة ستملأ الكرت الطولي بالكامل
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}