import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/eventController.dart';
import '../../Models/EventModel.dart';
import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/EventPreparation/FilterColored.dart';
import '../../Shared/Components/EventPreparation/PreparationComponents.dart';
import '../../Shared/Components/buttons.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';
import 'IfEmpty.dart';
import 'TodoList1.dart'; // تأكد من المسار

class Myevents extends StatefulWidget {
  const Myevents({super.key});

  @override
  State<Myevents> createState() => _MyeventsState();
}

class _MyeventsState extends State<Myevents> {
  final EventController controller = Get.put(EventController());

  @override
  void initState() {
    super.initState();
    controller.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarEventDetails(context, "مناسباتي",showLeftButton:false),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.eventList.isEmpty) {
                return const Center(child: Ifempty());
              }

              // منطق الفلترة والعرض
              Map<String, List<Widget>> filterData = {
                "الحالية": controller.eventList
                    .where((e) => e.status == EventStatus.current)
                    .map((e) => _buildResponsiveCard(e, 0.6, size, isLandscape))
                    .toList(),
                "القادمة": controller.eventList
                    .where((e) => e.status == EventStatus.upcoming)
                    .map((e) => _buildResponsiveCard(e, 0.0, size, isLandscape))
                    .toList(),
                "المنتهية": controller.eventList
                    .where((e) => e.status == EventStatus.finished)
                    .map((e) => _buildResponsiveCard(e, 1.0, size, isLandscape))
                    .toList(),
              };

              return Filtercolored(
                filterItems: filterData,
                initialFilter: "الحالية",
              );
            }),
          ),
        ],
      ),
    );
  }

  // دالة بناء الكارت المستقلة لضمان الريسبونسيف
  Widget _buildResponsiveCard(EventModel event, double progress, Size size, bool isLandscape) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isLandscape ? 800 : double.infinity, // تحديد عرض أقصى في اللاندسكيب
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.02),
          child: StatusEventCard(event: event, progress: progress),
        ),
      ),
    );
  }

  // كود الـ StatusEventCard داخل الكلاس... (يبقى كما هو مع تعديلات بسيطة في الـ Padding)
  Widget StatusEventCard({required EventModel event, required double progress}) {
    int remainingDays = DateTime.now().difference(event.updatedAt).inDays.abs();

    return GestureDetector(
      onTap: () {
        if (event.status == EventStatus.current || event.status == EventStatus.upcoming) {
          Get.to(() => Todolist1(eventName: event.arName, remainingDays: remainingDays));
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(w * 0.04),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: w * 0.03),
                      IntroSecondText(subtitle: event.arName, color: dark, size: w * 0.05),
                      SizedBox(height: w * 0.015),
                      IntroSecondText(subtitle: "نوع المناسبة: ${event.eventType}", color: secondText, size: w * 0.035),
                      SizedBox(height: w * 0.03),
                      Divider(height: w * 0.02),
                      Row(
                        children: [
                          Image.asset("assets/purpleDate.webp", width: w * 0.045),
                          SizedBox(width: w * 0.02),
                          IntroSecondText(subtitle: "تاريخ المناسبة:", color: dark, size: w * 0.035),
                          SizedBox(width: w * 0.015),
                          IntroSecondText(subtitle: "$remainingDays يوم متبقي", color: dark, size: w * 0.035),
                        ],
                      ),
                      SizedBox(height: w * 0.03),
                      Divider(height: w * 0.02),
                      Row(
                        children: [
                          IntroSecondText(subtitle: "الإنجاز", color: dark, size: w * 0.032),
                          SizedBox(width: w * 0.02),
                          Expanded(child: goldLineProgress(percent: progress, w: w)),
                          SizedBox(width: w * 0.02),
                          IntroSecondText(subtitle: "${(progress * 100).round()}%", color: dark, size: w * 0.032),
                        ],
                      ),
                      SizedBox(height: w * 0.05),
                      BlackBigIntroButton(title: buttonText(event.status)),
                    ],
                  ),
                ),
                Positioned(
                  top: w * 0.03,
                  left: w * 0.03,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: w * 0.012),
                    decoration: BoxDecoration(
                      color: statusColor(event.status),
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: IntroSecondText(subtitle: statusText(event.status), color: dark, size: w * 0.032),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}