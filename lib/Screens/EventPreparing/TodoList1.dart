import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/EventPreparation/PreparationComponents.dart';
import '../../Shared/Components/EventPreparation/TimeLine.dart';
import '../../Shared/Components/EventPreparation/TodoListFilter.dart';
import '../../Shared/Components/ServiceProvider/ServicesProviderComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Constants/constants.dart';
import '../../Shared/Style/Colors.dart';
import '../EventDetails/AddEssentialItem.dart';

class Todolist1 extends StatefulWidget {
  final String eventName;
  final int remainingDays;

  const Todolist1({
    super.key,
    required this.eventName,
    required this.remainingDays,
  });

  @override
  State<Todolist1> createState() => _Todolist1State();
}

void openWhatsApp(String phone) async {
  final Uri url = Uri.parse("https://wa.me/$phone");
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch WhatsApp';
  }
}

class _Todolist1State extends State<Todolist1> {
  bool showTimeInAppBar = false;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final size = MediaQuery.of(context).size;
        final bool isLandscape = orientation == Orientation.landscape;

        final w = size.width;
        final h = size.height;

        // تعريف البيانات داخل الـ Builder لضمان تحديث القياسات عند التدوير
        final Map<String, List<Widget>> filterData = {
          "الأساسيات": [
            _buildEssentialsHeader(w, h, isLandscape),
            SizedBox(height: isLandscape ? h * 0.04 : h * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
              child: outSearchBarHome(context: context, onChanged: (_) {}),
            ),
            SizedBox(height: h * 0.02),
            _buildEssentialsList(h),
          ],
          "يوم المناسبة": [
            VerticalTimeline(
              items: [
                TimelineItem(
                  title: "تم تأكيد الحجز",
                  serviceProviderName: "قاعة الفرح",
                  time: "10:00 ص",
                  status: "منتهي",
                  isCompleted: true,
                ),
                TimelineItem(
                  title: "التجهيز",
                  serviceProviderName: "التزيين",
                  time: "12:00 م",
                  status: "قيد التنفيذ",
                  isCompleted: false,
                ),
              ],
            ),
          ],
          "الإتصالات": [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
              child: outSearchBarHome(context: context, onChanged: (_) {}),
            ),
            SizedBox(height: h * 0.02),
            _buildCommunicationsList(w, h, isLandscape),
          ],
          "المهام": [
            _buildTasksColumn(h, isLandscape),
          ],
        };

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              AppBarEventDetails(
                context,
                widget.eventName,
                showTime: showTimeInAppBar,
                time: "${widget.remainingDays}",
              ),
              Expanded(
                child: Todolistfilter(
                  filterItems: filterData,
                  initialFilter: "الأساسيات",
                  onFilterChanged: (selectedFilter) {
                    setState(() {
                      showTimeInAppBar = selectedFilter == "يوم المناسبة";
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- ميثودات مساعدة لتنظيم الكود ومنع الـ Overflow ---

  Widget _buildEssentialsHeader(double w, double h, bool isLandscape) {
    return Row(
      children: [
        IntroSecondText(
          subtitle: "لا تنسى إنجاز",
          color: dark,
          size: isLandscape ? w * 0.025 : w * 0.038,
        ),
        SizedBox(width: w * 0.02),
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        SizedBox(width: w * 0.02),
        InkWell(
          onTap: () => Get.to(const Addessentialitem()),
          child: Row(
            children: [
              Icon(Icons.add, color: purple, size: isLandscape ? w * 0.04 : w * 0.055),
              SizedBox(width: w * 0.01),
              IntroSecondText(
                subtitle: "إضافة عنصر جديد",
                color: purple,
                size: isLandscape ? w * 0.022 : w * 0.035,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEssentialsList(double h) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: essentialsData.length,
      separatorBuilder: (_, __) => SizedBox(height: h * 0.02),
      itemBuilder: (context, index) {
        final item = essentialsData[index];
        return EssentialCard(
          itemName: item["name"],
          itemPlace: item["place"],
          itemTime: item["time"],
          isChecked: item["checked"],
          onChanged: (val) {
            setState(() => item["checked"] = val);
          },
        );
      },
    );
  }

  Widget _buildCommunicationsList(double w, double h, bool isLandscape) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        separatorBuilder: (_, __) => SizedBox(height: h * 0.015),
        itemBuilder: (context, index) {
          final service = services[index];
          return Padding(
            padding: EdgeInsets.all(isLandscape ? w * 0.015 : w * 0.03),
            child: Row(
              children: [
                CircleAvatar(
                  radius: isLandscape ? w * 0.04 : w * 0.065,
                  backgroundImage: NetworkImage(service['image']!),
                ),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IntroSecondText(
                        subtitle: service['name']!,
                        color: dark,
                        size: isLandscape ? w * 0.025 : w * 0.035,
                      ),
                      SizedBox(height: h * 0.005),
                      IntroSecondText(
                        subtitle: service['phone']!,
                        color: secondText,
                        size: isLandscape ? w * 0.025 : w * 0.035,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => openWhatsApp(service['phone']!),
                  child: Image.asset(
                    "assets/whatsapp.webp",
                    width: isLandscape ? w * 0.05 : w * 0.08,
                    height: isLandscape ? w * 0.05 : w * 0.08,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTasksColumn(double h, bool isLandscape) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElementDropDown(title: 'الأزهار', items: flowersList, image: 'assets/flower.webp', onSelectionChanged: (_) {}),
        SizedBox(height: isLandscape ? h * 0.04 : h * 0.025),
        ElementDropDown(title: 'الإضاءة', items: lightList, image: 'assets/light.webp', onSelectionChanged: (_) {}),
        SizedBox(height: isLandscape ? h * 0.04 : h * 0.025),
        ElementDropDown(title: 'الصوتيات', items: audioList, image: 'assets/audio.webp', onSelectionChanged: (_) {}),
        SizedBox(height: isLandscape ? h * 0.04 : h * 0.025),
        ElementDropDown(title: 'التصوير', items: audioList, image: 'assets/photo.webp', onSelectionChanged: (_) {}),
        SizedBox(height: isLandscape ? h * 0.04 : h * 0.025),
        ElementDropDown(title: 'الضيافة', items: audioList, image: 'assets/food.webp', onSelectionChanged: (_) {}),
        SizedBox(height: isLandscape ? h * 0.04 : h * 0.025),
        ElementDropDown(title: 'الأهازيج', items: audioList, image: 'assets/Chants.webp', onSelectionChanged: (_) {}),
      ],
    );
  }
}