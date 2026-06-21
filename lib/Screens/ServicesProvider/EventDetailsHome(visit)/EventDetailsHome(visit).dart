import 'package:flutter/material.dart' hide SearchBar;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../Models/ServiceModel.dart';
import '../../../Shared/Components/ServiceProvider/ServicesProviderComponents.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';
import '../EventCardDetailsScreen.dart';
import 'FilterPageView/BottomSheet.dart';
import 'FilterPageView/SortBottomSheet.dart';

class ServiceProvider extends StatefulWidget {
  ServiceProvider({super.key});

  @override
  State<ServiceProvider> createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  final List<ServiceModel> servicesData = [
    // ... بياناتك التجريبية (نفسها دون تغيير)
    ServiceModel(
      imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?q=80&w=1000',
      serviceName: 'تجهيز صالة زفاف ملكية',
      description: 'ديكور كامل مع إضاءة ليزر وكوشة حديثة',
      duration: '6 ساعات',
      priceBeforeDiscount: 1500000,
      priceAfterDiscount: 1200000,
      isFavorite: true,
      provider: 'قصر الأفراح',
      eventType: 'زفاف',
      category: 'صالة',
      specificType: '',
    ),
    // ... باقي البيانات
  ];

  Map<String, bool> eventSelections = {
    'جميع المناسبات': true, 'زواج': false, 'تخرج': false, 'عيد ميلاد': false,
  };
  Map<String, bool> durationSelections = {};
  late List<ServiceModel> filteredServices;
  String? selectedSort;

  @override
  void initState() {
    super.initState();
    filteredServices = servicesData;
  }

  // --- دوال الفلترة والفرز ---

  void handleFilterOpen() async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        initialEventSelections: eventSelections,
        initialDurationSelections: durationSelections,
      ),
    );

    if (result != null) {
      setState(() {
        eventSelections = result['event'];
        durationSelections = result['duration'];
        _applyFilters();
      });
    }
  }

  void handleSortOpen() async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SortBottomSheet(
        initialSort: selectedSort,
      ),
    );

    if (result != null) {
      setState(() {
        selectedSort = result;
        _applyFilters();
      });
    }
  }

  void _applyFilters() {
    final selectedEvents = eventSelections.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    List<ServiceModel> tempList = servicesData.where((service) {
      bool eventMatch = selectedEvents.contains('جميع المناسبات') ||
          selectedEvents.any((e) => service.eventType.contains(e));
      return eventMatch;
    }).toList();

    // تطبيق الترتيب
    if (selectedSort != null) {
      if (selectedSort == "السعر (من الأقل إلى الأعلى)") {
        tempList.sort((a, b) => (a.priceAfterDiscount ?? a.priceBeforeDiscount)
            .compareTo(b.priceAfterDiscount ?? b.priceBeforeDiscount));
      } else if (selectedSort == "السعر (من الأعلى إلى الأقل)") {
        tempList.sort((a, b) => (b.priceAfterDiscount ?? b.priceBeforeDiscount)
            .compareTo(a.priceAfterDiscount ?? a.priceBeforeDiscount));
      }
    }

    filteredServices = tempList;
  }

  int getCrossAxisCount(double width, bool isPortrait) {
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return isPortrait ? 2 : 3;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: isPortrait ? height * 0.025 : height * 0.04,
                left: width * 0.04,
                right: width * 0.04,
              ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_sharp, color: purple, size: 22)
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: outSearchBarHome(
                      context: context,
                      onChanged: (value) {
                        setState(() {
                          filteredServices = servicesData
                              .where((s) => s.serviceName.contains(value))
                              .toList();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: height * 0.02),

                  // 2. أزرار التصفية والفرز (تم تفعيل الـ onPressed)
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BirthdayHomeCardFilter(
                                context: context,
                                title: 'التصفية',
                                icon: 'assets/ic_filter.webp',
                                onPressed: handleFilterOpen // استدعاء الفلترة
                            ),
                            SizedBox(width: width * 0.03),
                            BirthdayHomeCardFilter(
                                context: context,
                                title: 'الفرز',
                                icon: 'assets/sort.webp',
                                onPressed: handleSortOpen // استدعاء الفرز
                            ),
                            SizedBox(width: width * 0.03),
                            BirthdayHomeCardFilter(context: context, title: 'عروضات', icon: 'assets/offers.webp', onPressed: () {}),
                            SizedBox(width: width * 0.03),
                            BirthdayHomeCardFilter(context: context, title: 'السعر', icon: 'assets/price.webp', onPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // 3. كروت الفئات
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: width * 0.02,
                        runSpacing: height * 0.012,
                        children: [
                          BirthdayFilterCard(image: 'assets/birthday.webp', type: 'كيك', context: context),
                          BirthdayFilterCard(image: 'assets/birthday.webp', type: 'شوكولا', context: context),
                          BirthdayFilterCard(image: 'assets/birthday.webp', type: 'طاولات', context: context),
                          BirthdayFilterCard(image: 'assets/birthday.webp', type: 'صحن', context: context),
                          BirthdayFilterCard(image: 'assets/birthday.webp', type: 'أزهار', context: context),
                          BirthdayFilterCard(image: 'assets/birthday.webp', type: 'صالة', context: context),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  // 4. شبكة الخدمات
// داخل كلاس _ServiceProviderState في تابع build:

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: getCrossAxisCount(width, isPortrait),
                      mainAxisSpacing: width * 0.04,
                      crossAxisSpacing: width * 0.04,
                      childAspectRatio: isPortrait ? 0.62 : 0.82,
                    ),
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      final item = filteredServices[index];

                      return GestureDetector(
                        onTap: () {
                          // الانتقال لصفحة التفاصيل باستخدام GetX
                          Get.to(() => EventCardDetails(
                            imageUrl: item.imageUrl,
                            serviceName: item.serviceName,
                            description: item.description,
                            duration: item.duration,
                            priceBeforeDiscount: item.priceBeforeDiscount,
                            priceAfterDiscount: item.priceAfterDiscount,
                            isFavorite: item.isFavorite,
                            category: item.category,
                            provider: item.provider,
                            specificType: item.specificType,
                            eventType: item.eventType,
                            // تمرير الصور: نستخدم صورة العنصر الأساسية + صور إضافية للعرض
                            images: [
                              item.imageUrl,
                              'https://picsum.photos/400/300?random=1',
                              'https://picsum.photos/400/300?random=2',
                            ],
                          ));
                        },
                        child: ServiceCardVertical(
                          context: context,
                          imageUrl: item.imageUrl,
                          serviceName: item.serviceName,
                          description: item.description,
                          duration: item.duration,
                          priceBeforeDiscount: item.priceBeforeDiscount,
                          priceAfterDiscount: item.priceAfterDiscount,
                          isFavorite: item.isFavorite,
                          category: item.category,
                          provider: item.provider,
                          specificType: item.specificType,
                          eventType: item.eventType,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.05),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}