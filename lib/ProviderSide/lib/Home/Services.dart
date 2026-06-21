import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// تأكد من بقاء مسارات الـ imports الخاصة بمشروعك كما هي
import '../../../Shared/Components/components.dart';
import '../Shared/Style/Colors.dart';
import '../createServices/ServiceDetailsPopUp.dart';
import '../shared/AppointmentComponent.dart';
import '../shared/cards.dart';

// ألوان احتياطية في حال عدم توفر ملف الألوان الخارجي
const Color darkColor = Color(0xFF1E1E1E);
const Color orangeColor = Colors.orange;
const Color greyText = Colors.grey;

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  String selectedFilter = "الكل";

  final List<Map<String, dynamic>> allServices = [
    {
      "name": "خدمة التصميم الاحترافي",
      "isActive": true,
      "oldPrice": 200.0,
      "newPrice": 150.0,
      "discount": 25,
      "count": "15 شخص"
    },
    {
      "name": "خدمة البرمجة",
      "isActive": false,
      "oldPrice": 500.0,
      "newPrice": 400.0,
      "discount": 20,
      "count": "10 أشخاص"
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredServices = allServices.where((service) {
      if (selectedFilter == "الكل") return true;
      if (selectedFilter == "مفعلة") return service["isActive"] == true;
      if (selectedFilter == "غير مفعلة") return service["isActive"] == false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          smallWelcomeCard(context: context, userName: "خدماتي"),
          const SizedBox(height: 10),

          // --- قسم الفلترة المعدل ليصبح Space Between عند الروتيت ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: double.infinity, // أخذ كامل العرض
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5), // اللون الرمادي الفاتح المعتاد
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                // السر هنا: توزيع العناصر بمسافات متساوية تماماً
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterOption("الكل", Colors.grey, "الكل"),
                  _buildFilterOption("مفعلة", Colors.green, "مفعلة"),
                  _buildFilterOption("غير مفعلة", Colors.red, "غير مفعلة"),
                ],
              ),
            ),
          ),
          // -------------------------------------------------------

          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: filteredServices.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                var item = filteredServices[index];
                return Center(
                  child: CustomServiceCard(
                    serviceName: item["name"],
                    imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?q=80&w=600&auto=format&fit=crop',
                    isActive: item["isActive"],
                    originalPrice: item["oldPrice"],
                    discountedPrice: item["newPrice"],
                    discountPercentage: item["discount"],
                    userCountText: item["count"],
                    userAvatars: const [
                      "https://i.pravatar.cc/150?u=1",
                      "https://i.pravatar.cc/150?u=2",
                      "https://i.pravatar.cc/150?u=3",
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // دالة بناء خيار الفلتر لضمان استجابة المساحات
  Widget _buildFilterOption(String title, Color color, String value) {
    bool isSelected = selectedFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = value;
        });
      },
      behavior: HitTestBehavior.opaque, // لجعل منطقة الضغط أكبر
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.black : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'BahijTheSansArabic',
            ),
          ),
        ],
      ),
    );
  }
}

class CustomServiceCard extends StatelessWidget {
  final String serviceName;
  final String imageUrl;
  final bool isActive;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercentage;
  final List<String> userAvatars;
  final String userCountText;
  final String description;
  final String duration;

  const CustomServiceCard({
    Key? key,
    required this.serviceName,
    required this.imageUrl,
    required this.isActive,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.userAvatars,
    required this.userCountText,
    this.description = "وصف الخدمة الافتراضي يظهر هنا...",
    this.duration = "ساعتين",
  }) : super(key: key);

  void _openDetailsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EventDetailsBottomSheet(
        serviceName: serviceName,
        imageUrl: imageUrl,
        images: [imageUrl, imageUrl, imageUrl],
        description: description,
        duration: duration,
        priceBeforeDiscount: originalPrice,
        priceAfterDiscount: discountedPrice,
        provider: "اسم المزود",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => _openDetailsSheet(context),
      child: Container(
        width: availableWidth * 0.92,
        constraints: const BoxConstraints(maxWidth: 400),
        height: 252.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: Image.network(
                    imageUrl,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 4,
                  child: PopupMenuButton<String>(
                    color: Colors.white,
                    icon: const Icon(Icons.more_horiz, color: Colors.black, size: 28),
                    offset: const Offset(0, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    onSelected: (value) {
                      if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (context) => DeleteServiceDialog(
                            onDelete: () => Navigator.pop(context),
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      _buildMenuItem('delete', Icons.delete, 'حذف', Colors.red),
                      _buildMenuItem('edit', Icons.mode_edit, 'تعديل', Colors.orange),
                      _buildMenuItem('view', Icons.visibility, 'عرض كمستخدم', Colors.green),
                      _buildMenuItem('manage', Icons.multiline_chart, 'إدارة الحجوزات', Colors.black),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: IntroSecondText(subtitle: serviceName, color: darkColor, size: 16)),
                        _buildStatusBadge(),
                      ],
                    ),
                    _buildPriceRow(),
                    _buildAvatarsRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(String val, IconData icon, String title, Color color) {
    return PopupMenuItem(
      value: val,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          IntroSecondText(subtitle: title, color: darkColor, size: 12)
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IntroSecondText(subtitle: isActive ? "مفعلة" : "غير مفعلة", color: Colors.white, size: 14),
    );
  }

  Widget _buildPriceRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          IntroSecondText(subtitle: "السعر:", color: darkColor, size: 14),
          const SizedBox(width: 8),
          IntroSecondText(subtitle: "\$${discountedPrice.toStringAsFixed(0)}", color: orangeColor, size: 16),
          const SizedBox(width: 8),
          Text(
            "\$${originalPrice.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: IntroSecondText(subtitle: "-$discountPercentage%", color: orangeColor, size: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarsRow() {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 28,
          child: Stack(
            children: List.generate(
              userAvatars.length > 3 ? 3 : userAvatars.length,
                  (index) => Positioned(
                left: index * 15.0,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(userAvatars[index]),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        IntroSecondText(subtitle: userCountText, color: greyText, size: 13)
      ],
    );
  }
}


class DeleteServiceDialog extends StatelessWidget {
  final VoidCallback onDelete;
  const DeleteServiceDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      child: Container(
        width: isLandscape ? screenWidth * 0.5 : screenWidth * 0.85,
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.9,
          maxWidth: 450,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // الصور العلوية
              Positioned(top: 0, right: 0, child: Image.asset("assets/topRight (2).webp", width: isLandscape ? screenWidth * 0.08 : screenWidth * 0.2)),
              Positioned(top: 0, left: 0, child: Image.asset("assets/topLeft (2).webp", width: isLandscape ? screenWidth * 0.1 : screenWidth * 0.22)),

              // المفرقعات السفلية
              Positioned(bottom: 0, right: 0, child: Image.asset("assets/bottomRight (2).webp", width: isLandscape ? screenWidth * 0.08 : screenWidth * 0.2)),
              Positioned(bottom: 0, left: 0, child: Image.asset("assets/bottomLeft (2).webp", width: isLandscape ? screenWidth * 0.1 : screenWidth * 0.22)),

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.04,
                  horizontal: screenWidth * 0.06,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: screenHeight * 0.02),

                    // الصورة المركزية (Asset)
                    Container(
                      height: isLandscape ? screenHeight * 0.15 : 110,
                      width: isLandscape ? screenHeight * 0.15 : 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFEBEE),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset("assets/delete.webp", fit: BoxFit.contain),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // العنوان الأساسي
                    IntroSecondText(
                      subtitle: "هل أنت متأكد من حذف الخدمة؟",
                      color: darkColor,
                      size: isLandscape ? 16 : 18,
                    ),

                    SizedBox(height: screenHeight * 0.015),

                    // النص الرمادي (تنسيق هرمي وريسبونسف)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Text(
                        "سيتم حذف هذه الخدمة نهائياً ولن تظهر للعملاء بعد الآن. لا يمكن التراجع عن هذا الإجراء.",
                        textAlign: TextAlign.center, // لتحقيق الشكل الهرمي بالتوسط
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: isLandscape ? 12 : 14,
                          height: 1.5, // لزيادة تباعد الأسطر وجعلها مريحة للعين
                          fontFamily: 'BahijTheSansArabic', // تأكدي من مطابقة اسم الخط في pubspec.yaml
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // أزرار التحكم
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onDelete,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child:IntroSecondText(subtitle:"حذف", color:Colors.white, size:12),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child:IntroSecondText(subtitle:"إلغاء", color:Colors.red, size:12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}