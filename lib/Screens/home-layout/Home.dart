import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/profileController.dart';
import '../../Shared/Components/Cards.dart';
import '../../Shared/Components/ServiceProvider/ServicesProviderComponents.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import '../EventDetails/Trends.dart';
import '../ServicesProvider/EventDetailsHome(visit)/EventDetailsHome(visit).dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          final size = MediaQuery.of(context).size;
          final double screenW = size.width;
          final double screenH = size.height;
          final bool isLandscape = orientation == Orientation.landscape;

          return Obx(() {
            final profile = controller.profile.value;
            final userName = profile?.firstName ?? 'Guest';

            return SingleChildScrollView(
              child: Column(
                children: [
                  // كارد الترحيب المعدل (نحيف جداً في الروتيت)
                  WelcomeCard(context: context, userName: userName),

                  SizedBox(height: isLandscape ? 10 : screenH * 0.02),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenW * 0.035,
                      vertical: screenH * 0.015,
                    ),
                    child: Column(
                      children: [
                        // البانر
                        SizedBox(
                            height: isLandscape ? 120 : screenH * 0.18,
                            width: double.infinity,
                            child: DiscountCard(discount: 1, context: context)
                        ),

                        SizedBox(height: isLandscape ? 20 : screenH * 0.03),

                        /// --- قسم الفلاتر المعدل للتوزيع المنتظم ---
                        if (isLandscape)
                        // في الروتيت نستخدم Row لتوزيعها على كامل العرض
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _getFilterCards(context),
                            ),
                          )
                        else
                        // في الوضع الطولي نتركها ListView قابلة للتمرير
                          _buildResponsiveSection(
                            context,
                            height: screenW * 0.32,
                            addExtraShadow: true,
                            children: _getFilterCards(context),
                          ),

                        SizedBox(height: isLandscape ? 20 : screenH * 0.03),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSectionTitle('مزودي الخدمة', screenW, isLandscape),
                            IntroTextButton(title: 'الكل', size: 16,
                                onPressed: () {
                                  Get.to(ServiceProvider());
                                })
                          ],
                        ),

                        /// قسم مزودي الخدمة
                        _buildResponsiveSection(
                          context,
                          height: isLandscape ? 200 : screenH * 0.29,
                          addExtraShadow: true,
                          children: List.generate(4, (index) =>
                              ServiceProviderCardPhoto(
                                imageUrl: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                                name: 'مزود الخدمة',
                                rating: 4.5,
                                discount: 20, context:context,
                              ),
                          ),
                        ),

                        SizedBox(height: isLandscape ? 20 : screenH * 0.03),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSectionTitle('التريندات', screenW, isLandscape),
                            IntroTextButton(title: 'الكل', size: 16,
                                onPressed: () {
                                  Get.to(Trends());
                                })
                          ],
                        ),

                        /// قسم التريندات
                        _buildResponsiveSection(
                          context,
                          height: isLandscape ? 140 : screenH * 0.20,
                          addExtraShadow: true,
                          children: List.generate(4, (index) =>
                              TrendCard(
                                imageUrl: 'https://picsum.photos/300/200',
                                title: 'كارد ${index + 1}',
                              ),
                          ),
                        ),

                        SizedBox(height: isLandscape ? 40 : screenH * 0.03),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  // دالة مساعدة لتعريف الكاردات مرة واحدة
  List<Widget> _getFilterCards(BuildContext context) {
    return [
      FilterCard(image: 'assets/graduate.webp', type: 'تخرج', context: context),
      FilterCard(image: 'assets/babyBirth.webp', type: 'ولادة', context: context),
      FilterCard(image: 'assets/married.webp', type: 'زواج', context: context),
      FilterCard(image: 'assets/birthday.webp', type: 'أعياد ميلاد', context: context),
    ];
  }

  Widget _buildSectionTitle(String title, double screenW, bool isLandscape) {
    return Align(
      alignment: Alignment.topRight,
      child: IntroSecondText(
        subtitle: title,
        color: dark,
        size: isLandscape ? 16 : screenW * 0.045,
      ),
    );
  }

  Widget _buildResponsiveSection(BuildContext context, {
    required double height,
    required List<Widget> children,
    bool addExtraShadow = false,
  }) {
    final double screenW = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: double.infinity,
      color: Colors.transparent,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemCount: children.length,
        separatorBuilder: (context, index) => SizedBox(width: screenW * 0.04),
        itemBuilder: (context, index) {
          return Container(
            decoration: addExtraShadow ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ) : null,
            child: children[index],
          );
        },
      ),
    );
  }
}