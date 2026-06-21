import 'package:flutter/material.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/ServiceProvider/ServicesProviderComponents.dart';

class Trends extends StatefulWidget {
  const Trends({super.key});

  @override
  State<Trends> createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  final List<TrendItem> trendItems = [
    TrendItem(imageUrl: 'https://via.placeholder.com/150', title: 'ترند 1'),
    TrendItem(imageUrl: 'https://via.placeholder.com/150', title: 'ترند 2'),
    TrendItem(imageUrl: 'https://via.placeholder.com/150', title: 'ترند 3'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarEventDetails(
              context,
              "أحدث التريندات",
              showLeftButton: false,
              showTime: false,
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: ListView.builder(
                // هنا السر: نزيد البادينغ الجانبي بشكل كبير في وضع الـ Rotate
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: isPortrait
                      ? size.width * 0.05  // في الوضع الطولي البادينغ 5%
                      : size.width * 0.25, // في الـ Rotate البادينغ 25% من كل جهة لتصغير الكارد
                ),
                itemCount: trendItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: TrendCardPage(
                      imageUrl: trendItems[index].imageUrl,
                      title: trendItems[index].title,
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
}

class TrendItem {
  final String imageUrl;
  final String title;
  TrendItem({required this.imageUrl, required this.title});
}