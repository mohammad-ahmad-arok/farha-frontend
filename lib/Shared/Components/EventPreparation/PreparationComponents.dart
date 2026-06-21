
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../Models/SupplierModel.dart';
import '../../../Screens/ServicesProvider/EventDetailsHome(visit)/EventDetailsHome(visit).dart';
import '../../Style/Colors.dart';
import '../buttons.dart';
import '../components.dart';
////////////////////////Element
class DropdownItem {
  final String id;
  final String title;
  bool isSelected;

  DropdownItem({
    required this.id,
    required this.title,
    this.isSelected = false,
  });
}

class ElementDropDown extends StatefulWidget {
  final String title;
  final List<DropdownItem> items;
  final Function(List<DropdownItem>) onSelectionChanged;
  final String image;

  const ElementDropDown({
    super.key,
    required this.title,
    required this.items,
    required this.onSelectionChanged,
    required this.image

  });

  @override
  State<ElementDropDown> createState() => _ElementDropDownState();
}

class _ElementDropDownState extends State<ElementDropDown> {
  bool isExpanded = false;
  bool showCards = false;

  final Map<String, String> categoryImages = {
    'الأزهار': 'assets/flowerCover.jpg',
    'الضيافة': 'assets/sweetCover.jpg',
    'التصوير': 'assets/photoCover.jpg',
    'الصالة': 'assets/cover.jpg',
    'الأهازيج': 'assets/photoCover.jpg',
    'الصوتيات': 'assets/photoCover.jpg',
  };

  String getCardImage() {
    return categoryImages[widget.title] ??
        'assets/images/default_bg.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== Header =====
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.018,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    /// Icon + Title
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.07,
                            height: size.width * 0.07,
                            child: Image.asset(
                              widget.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: IntroSecondText(
                              subtitle: widget.title,
                              color: dark,
                              size: isSmallScreen ? 14 : 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: size.width * 0.07,
                    ),
                  ],
                ),
              ),
            ),

            /// ===== Content =====
            if (isExpanded)
              Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                padding: EdgeInsets.all(size.width * 0.025),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    /// ===== CHECKBOX MODE =====
                    if (!showCards)
                      ...widget.items.map((item) {
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: item.isSelected,
                          title: IntroSecondText(
                            subtitle: item.title,
                            color: dark,
                            size: isSmallScreen ? 14 : 16,
                          ),
                          controlAffinity:
                          ListTileControlAffinity.leading,
                          activeColor: purple,
                          onChanged: (value) {
                            setState(() {
                              item.isSelected = value ?? false;
                            });

                            widget.onSelectionChanged(
                              widget.items
                                  .where((e) => e.isSelected)
                                  .toList(),
                            );
                          },
                        );
                      }).toList(),

                    /// ===== CONFIRM BUTTON =====
                    if (!showCards)
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.01,
                        ),
                        child: IntroTextButton(
                          size: isSmallScreen ? 14 : 16,
                          title: 'تم',
                          onPressed: () {
                            setState(() {
                              showCards = true;
                            });
                          },
                        ),
                      ),

                    /// ===== SELECTED CARDS =====
                    if (showCards)
                      ...widget.items
                          .where((e) => e.isSelected)
                          .map((item) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: size.height * 0.01,
                          ),
                          child: ElementCard(
                            service: item.title,
                            image: getCardImage(),
                            supplier: null,
                          ),
                        );
                      }).toList(),

                    /// ===== EDIT BUTTON =====
                    if (showCards)
                      IntroTextButton(
                        title: "تعديل الإختيار",
                        size: isSmallScreen ? 14 : 16,
                        onPressed: () {
                          setState(() {
                            showCards = false;
                          });
                        },
                      ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}






Color getStatusColor(String? status) {
  switch (status) {
    case 'delivered':
      return Colors.red;
    case 'waiting_confirm':
      return orange;
    case 'booked':
      return Colors.green;
    default:
      return Colors.white; // غير محدد
  }
}

String getStatusText(String? status) {
  switch (status) {
    case 'waiting_confirm':
      return 'بانتظار التأكيد';
    case 'delivered':
      return 'تم التسليم';
    case 'booked':
      return 'تم الحجز';
    default:
      return 'غير محدد';
  }
}

String getButtonText(String? status) {
  switch (status) {
    case 'waiting_confirm':
      return 'تعديل';
    case 'booked':
      return 'عرض التفاصيل';
    case 'delivered':
    default:
      return 'اختيار مقدم خدمة';
  }
}

Widget ElementCard({
  required String service,
  Supplier? supplier,
  required String image,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isSmall = width < 360;

      return Container(
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== MAIN CONTENT =====
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===== TOP ROW =====
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.085,
                        height: width * 0.085,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: width * 0.05,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: IntroSecondText(
                          subtitle: service,
                          color: Colors.black,
                          size: isSmall ? 15 : 18,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: width * 0.025),

                  /// ===== SUPPLIER =====
                  supplier == null
                      ? IntroSecondText(
                    subtitle: 'غير محدد بعد',
                    color: dark,
                    size: isSmall ? 12 : 14,
                  )
                      : Row(
                    children: [
                      CircleAvatar(
                        radius: width * 0.04,
                        backgroundImage:
                        NetworkImage(supplier.picture),
                        backgroundColor: Colors.grey.shade300,
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: IntroSecondText(
                          subtitle: supplier.arName,
                          color: Colors.black,
                          size: isSmall ? 12 : 14,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: width * 0.03),

                  /// ===== ACTION BUTTON =====
                  InkWell(
                    onTap: () {
                      Get.to(ServiceProvider());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: width * 0.015,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: light,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IntroSecondText(
                            subtitle:
                            getButtonText(supplier?.statue),
                            color: dark,
                            size: isSmall ? 11 : 12,
                          ),
                          SizedBox(width: width * 0.015),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: purple,
                            size: width * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: width * 0.02),

            /// ===== STATUS =====
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.025,
                vertical: width * 0.015,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: getStatusColor(supplier?.statue),
              ),
              child: IntroSecondText(
                subtitle: getStatusText(supplier?.statue),
                color: Colors.black,
                size: isSmall ? 11 : 12,
              ),
            ),
          ],
        ),
      );
    },
  );
}

///////////////////////////////////
enum EventStatus {
  current,
  upcoming,
  finished,
}
Color statusColor(EventStatus status) {
  switch (status) {
    case EventStatus.current:
      return orange;
    case EventStatus.upcoming:
      return secondText;
    case EventStatus.finished:
      return Colors.red;
  }
}

String statusText(EventStatus status) {
  switch (status) {
    case EventStatus.current:
      return "حالية";
    case EventStatus.upcoming:
      return "قادمة";
    case EventStatus.finished:
      return "منتهية";
  }
}

String buttonText(EventStatus status) {
  switch (status) {
    case EventStatus.current:
      return "متابعة المناسبة";
    case EventStatus.upcoming:
      return "عرض التفاصيل";
    case EventStatus.finished:
      return "عرض التقرير";
  }
}

Widget goldLineProgress({
  required double percent, // من 0.0 إلى 1.0
  required double w,
}) {
  final percentage = (percent * 100).round();

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 3, // 👈 خط رفيع
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFFD4AF37), // 👈 دهبي أنيق
            ),
          ),
        ),
      ),
      SizedBox(width: w * 0.025),
    ],
  );
}
List people = [
  {
    "user": "Ahmed",
    "role": "Admin",
    "image": "https://...your-image-url-1"
  },
  {
    "user": "Sara",
    "role": "User",
    "image": "https://...your-image-url-2"
  },
];

Widget EssentialCard({
  required String itemName,
  required String itemPlace,
  required String itemTime,
  required bool isChecked,
  required ValueChanged<bool?> onChanged,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isSmall = width < 360;

      return Container(
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== CONTENT =====
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// اسم العنصر
                  IntroSecondText(
                    subtitle: itemName,
                    color: secondText,
                    size: isSmall ? 16 : 18,
                  ),

                  SizedBox(height: width * 0.025),

                  /// الوقت والمكان
                  IntroSecondText(
                    subtitle: "$itemTime  -  $itemPlace",
                    color: secondText,
                    size: isSmall ? 12 : 14,
                  ),

                  SizedBox(height: width * 0.025),

                  /// مخصص ل
                  Row(
                    children: [
                      Image.asset(
                        "assets/purpleprofileIcon.webp",
                        width: width * 0.035,
                      ),
                      SizedBox(width: width * 0.015),
                      IntroSecondText(
                        subtitle: "مخصص ل:",
                        color: secondText,
                        size: 12,
                      ),
                    ],
                  ),

                  SizedBox(height: width * 0.03),

                  /// GRID
                  /// الأشخاص (Row + Responsive)
                  Wrap(
                    spacing: width * 0.03,
                    runSpacing: width * 0.02,
                    children: people.map((person) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: width * 0.045,
                            backgroundImage: NetworkImage(person["image"]),
                          ),
                          SizedBox(width: width * 0.015),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IntroSecondText(
                                subtitle: person["user"],
                                color: Colors.black87,
                                size: isSmall ? 12 : 14,
                              ),
                              IntroSecondText(
                                subtitle: person["role"],
                                color: Colors.black45,
                                size: 11,
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),                ],
              ),
            ),

            SizedBox(width: width * 0.02),

            /// ===== CHECKBOX =====
            Align(
              alignment: Alignment.topCenter,
              child: Checkbox(
                value: isChecked,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
    },
  );
}
/////////////////////لمين المهمة الاساسية
class CustomMultiSelect extends StatefulWidget {
  final Function(List<String>) onChanged;

  const CustomMultiSelect({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<CustomMultiSelect> createState() => _CustomMultiSelectState();
}

class _CustomMultiSelectState extends State<CustomMultiSelect>
    with TickerProviderStateMixin {

  final List<Map<String, dynamic>> items = [
    {
      'name': 'مهمة ثانوية',
      'description': 'وصف المهمة الثانوية',
      'icon': Icons.work_outline,
    },
    {
      'name': 'مهمة اختيارية',
      'description': 'وصف المهمة الاختيارية',
      'icon': Icons.check_circle_outline,
    },
  ];

  bool expanded = false;
  Map<String, bool> selected = {};

  @override
  void initState() {
    super.initState();
    for (var item in items) {
      selected[item['name']] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Container(
        padding: EdgeInsets.all(size.width * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// العنوان
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() => expanded = !expanded);
              },
              child: Row(
                children: [
                  Expanded(
                    child: IntroSecondText(
                      subtitle: selected.entries
                          .where((e) => e.value)
                          .map((e) => e.key)
                          .join(', ')
                          .isEmpty
                          ? 'اختر نوع المهمة'
                          : selected.entries
                          .where((e) => e.value)
                          .map((e) => e.key)
                          .join(', '),
                      color: secondText,
                      size: isSmall ? 13 : 14,
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: isSmall ? 22 : 26,
                  ),
                ],
              ),
            ),

            /// العناصر
            if (expanded) ...[
              SizedBox(height: size.height * 0.015),
              Column(
                children: items.map((item) {
                  return Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: size.height * 0.006),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: isSmall ? 16 : 18,
                          backgroundColor: purple,
                          child: Icon(
                            item['icon'],
                            color: Colors.white,
                            size: isSmall ? 16 : 18,
                          ),
                        ),
                        SizedBox(width: size.width * 0.025),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntroSecondText(
                                subtitle: item['name'],
                                color: dark,
                                size: isSmall ? 13 : 14,
                              ),
                              IntroSecondText(
                                subtitle: item['description'],
                                color: Colors.grey,
                                size: isSmall ? 11 : 12,
                              ),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: selected[item['name']],
                          activeColor: purple,
                          checkColor: Colors.white,
                          side: const BorderSide(color: Colors.grey),
                          visualDensity: VisualDensity.compact,
                          onChanged: (val) {
                            setState(() {
                              selected[item['name']] = val ?? false;
                              widget.onChanged(
                                selected.entries
                                    .where((e) => e.value)
                                    .map((e) => e.key)
                                    .toList(),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


void showSharePopup({required BuildContext context}) {
  final size = MediaQuery.of(context).size;
  final shortest = size.shortestSide;

  final dialogWidth = shortest * 0.9;
  final iconSize = shortest * 0.1;
  final circleSize = shortest * 0.25;

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: shortest * 0.05),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: dialogWidth.clamp(280, 420),
              margin: EdgeInsets.only(top: circleSize / 2),
              padding: EdgeInsets.fromLTRB(
                shortest * 0.05,
                circleSize / 1.4,
                shortest * 0.05,
                shortest * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IntroSecondText(
                    subtitle: 'شارك المخطط الخاص بك مع من تحب',
                    color: dark,
                    size: shortest < 360 ? 13 : 14,
                  ),
                  SizedBox(height: shortest * 0.06),

                  /// أيقونات المشاركة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/saveFile.webp",
                        width: iconSize.clamp(28, 40),
                        height: iconSize.clamp(28, 40),
                      ),
                      Image.asset(
                        "assets/savePhoto.webp",
                        width: iconSize.clamp(28, 40),
                        height: iconSize.clamp(28, 40),
                      ),
                      // تم تصغير الواتساب هنا
                      Image.asset(
                        "assets/whatsapp.webp",
                        width: iconSize.clamp(22, 32), // كانت 26-38
                        height: iconSize.clamp(22, 32),
                      ),
                    ],
                  ),

                  SizedBox(height: shortest * 0.06),

                  Align(
                    alignment: Alignment.centerRight,
                    child: IntroSecondText(
                      subtitle: 'نسخ الرابط',
                      color: dark,
                      size: 14,
                    ),
                  ),
                  SizedBox(height: shortest * 0.025),

                  /// صندوق الرابط
                  InkWell(
                    onTap: () {
                      // copy logic
                    },
                    child: Container(
                      height: shortest * 0.14,
                      constraints: const BoxConstraints(minHeight: 48),
                      padding: EdgeInsets.symmetric(horizontal: shortest * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        // تم استخدام Center و MainAxisAlignment للتوسيط
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy, size: 18, color: secondText),
                          SizedBox(width: shortest * 0.03),
                          // أزلنا Expanded لجعل النص يتمركز في المنتصف تماماً مع الأيقونة
                          Padding(
                            padding: const EdgeInsets.only(top:16.0),
                            child: Flexible(
                              child: IntroSecondText(
                                subtitle: "https://example.com/share",
                                color: secondText,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// زر المشاركة الدائري العلوي
            Positioned(
              top: -circleSize / 4,
              child: Container(
                width: circleSize.clamp(70, 90),
                height: circleSize.clamp(70, 90),
                decoration: BoxDecoration(
                  color: purple,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: circleSize.clamp(32, 40) / 1.8,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}