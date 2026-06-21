import 'package:flutter/material.dart' hide SearchBar;

import '../../Shared/Components/Cards.dart';
import '../../Shared/Components/ServiceProvider/Gallery.dart';
import '../../Shared/Components/ServiceProvider/PageFilterCard.dart';
import '../../Shared/Components/ServiceProvider/RateOfService.dart';
import '../../Shared/Components/ServiceProvider/ServicesProviderComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class Servicesproviderhome extends StatefulWidget {
  const Servicesproviderhome({super.key});

  @override
  State<Servicesproviderhome> createState() => _ServicesproviderhomeState();
}

final List<String> imageUrls = [
  "https://picsum.photos/id/101/300/300",
  "https://picsum.photos/id/102/300/300",
  "https://picsum.photos/id/103/300/300",
  "https://picsum.photos/id/104/300/300",
  "https://picsum.photos/id/103/300/300",
  "https://picsum.photos/id/104/300/300",
];

class _ServicesproviderhomeState extends State<Servicesproviderhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isLandscape = orientation == Orientation.landscape;
          final size = MediaQuery.of(context).size;
          final width = size.width;
          final height = size.height;

          final Map<String, List<Widget>> filterData = {
            "تقييمات وأراء": [
              RatingThinBars(),
              SizedBox(height: isLandscape ? 8 : height * 0.02),
              UserComment(
                userName: "أحمد محمد",
                userImage: "https://i.pravatar.cc/150",
                rating: 4,
                comment: "الخدمة ممتازة وسريعة، أكيد رح أتعامل معهم مرة ثانية.", context:context,
              ),
            ],
            "الخدمات": [
              SearchBar(
                context: context,
                onChanged: (value) {},
              ),
              SizedBox(height: isLandscape ? 8 : height * 0.015),
              ServiceCard(
                context: context,
                imageUrl: "https://picsum.photos/300/200",
                serviceName: "خدمة صيانة",
                description: "خدمة صيانة عامة للأجهزة الكهربائية.",
                duration: "3 ساعات",
                priceBeforeDiscount: 200,
                priceAfterDiscount: 100,
                discountPercent: 10,
                category: 'زهور',
                provider: '',
                specificType: '',
                eventType: 'حفلة تخرج',
              ),
            ],
            "حول المتجر": [
              // استخدام Wrap أو تخفيف المسافات في الـ Landscape لضمان عدم خروج العناصر
              DiscountCard(discount: 30, context: context),
              SizedBox(height: isLandscape ? 8 : height * 0.015),
              DescriptionCard(description: 'هنا تطبيق فرحة للمناسبات '),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: isLandscape ? 4 : width * 0.02
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IntroText(title: "معرض الصور", color: dark),
                ),
              ),
              const Gallery()
            ],
          };

          return Column(
            children: [
              AppBarServicesProvider(
                context: context,
                name: 'أزهار الامل',
                rate: 4.7,
              ),

              // مساحة ذكية: في الروتيت تكون صغيرة جداً لترك مساحة للكروت
              SizedBox(height: isLandscape ? 30 : 40),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isLandscape ? size.width * 0.05 : 0),
                  child: FilterWidget(
                    filterItems: filterData,
                    initialFilter: "تقييمات وأراء",
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}