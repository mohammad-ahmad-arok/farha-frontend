import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart' as picker;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Style/Colors.dart';

class Todolist5 extends StatefulWidget {
  const Todolist5({super.key});

  @override
  State<Todolist5> createState() => _Todolist5State();
}

class _Todolist5State extends State<Todolist5> {
  int rating = -1;
  List<picker.PlatformFile> attachments = [];
  List<File> reviewImages = [];
  String reviewText = "";
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double w = mediaQuery.size.width;
    final double h = mediaQuery.size.height;
    // استخدام shortestSide للأحجام الثابتة مثل الأيقونات والخطوط لضمان عدم تضخمها في الروتيت
    final double baseUnit = mediaQuery.size.shortestSide;
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: light,
      body: SafeArea(
        child: Column(
          children: [
            AppBarEventDetails(context, "اسم مقدم الخدمة"),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.05,
                    vertical: isLandscape ? 10 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle("مزود الخدمة", baseUnit),
                      SizedBox(height: h * 0.02),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                        ),
                        padding: EdgeInsets.all(baseUnit * 0.03),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: baseUnit * 0.08, // حجم متناسق في الحالتين
                              backgroundColor: Colors.redAccent,
                            ),
                            SizedBox(width: w * 0.03),
                            IntroSecondText(
                              subtitle: "ليدا",
                              color: dark,
                              size: baseUnit * 0.05,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: isLandscape ? 15 : 30),

                      sectionTitle("الوقت والتاريخ", baseUnit),
                      SizedBox(height: h * 0.015),

                      infoRow("assets/purpleDateIcon.webp", "التاريخ", baseUnit),
                      SizedBox(height: 10),
                      infoRow("assets/purpleWatch.webp", "الوقت", baseUnit),

                      SizedBox(height: isLandscape ? 15 : 30),

                      /// تقييم الخدمة
                      Row(
                        children: [
                          Expanded(child: sectionTitle("تقييم الخدمة", baseUnit)),
                          InkWell(
                            onTap: () => showRatingBottomSheet(context, w, h, baseUnit),
                            child: IntroSecondText(
                              subtitle: "إضافة تقييم",
                              color: purple,
                              size: baseUnit * 0.04,
                            ),
                          ),
                        ],
                      ),

                      if (rating >= 0) ...[
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(
                            5,
                                (i) => Icon(
                              Icons.star,
                              color: i <= rating ? Colors.amber : Colors.grey,
                              size: baseUnit * 0.06,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (reviewText.isNotEmpty)
                          IntroSecondText(subtitle: reviewText, color: dark, size: baseUnit * 0.035),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: reviewImages
                              .map(
                                (img) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                img,
                                width: isLandscape ? w * 0.15 : 70,
                                height: isLandscape ? w * 0.15 : 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              .toList(),
                        ),
                      ],

                      SizedBox(height: isLandscape ? 15 : 30),

                      /// المرفقات
                      Row(
                        children: [
                          Expanded(child: sectionTitle("المرفقات", baseUnit)),
                          InkWell(
                            onTap: () => showFilesBottomSheet(context, w, h, baseUnit),
                            child: IntroSecondText(
                              subtitle: "إضافة مرفقات",
                              color: purple,
                              size: baseUnit * 0.04,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Column(
                        children: attachments.map((file) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              (file.extension?.toLowerCase() == "mp4")
                                  ? Icons.videocam
                                  : Icons.insert_drive_file,
                              color: purple,
                              size: baseUnit * 0.06,
                            ),
                            title: Text(
                              file.name,
                              style: TextStyle(
                                fontFamily: 'BahijTheSansArabic',
                                fontSize: baseUnit * 0.035,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // مساحة أمان سفلية للروتيت
                      SizedBox(height: isLandscape ? 40 : 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ====== Bottom Sheet : Files ======
  void showFilesBottomSheet(BuildContext context, double w, double h, double baseUnit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // مهم جداً للروتيت
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          // في الروتيت نجعل الطول يعتمد على محتوى الصف
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: 20,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () { Navigator.pop(context); pickFile(); },
                    child: dottedItem("assets/fromFile.webp", "من الملفات", baseUnit),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () { Navigator.pop(context); pickFromGallery(); },
                    child: dottedItem("assets/fromgellary.webp", "من المعرض", baseUnit),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () { Navigator.pop(context); pickFromCamera(); },
                    child: dottedItem("assets/fromCamera.webp", "كاميرا", baseUnit),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ====== Bottom Sheet : Rating ======
  void showRatingBottomSheet(BuildContext context, double w, double h, double baseUnit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.only(
                left: 20, right: 20, top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: StatefulBuilder(
                builder: (context, setModalState) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              Icons.star,
                              color: index <= rating ? Colors.amber : Colors.grey,
                              size: baseUnit * 0.08,
                            ),
                            onPressed: () {
                              setModalState(() => rating = index);
                              setState(() {});
                            },
                          );
                        }),
                      ),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          maxLines: null,
                          onChanged: (val) {
                            reviewText = val;
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            hintText: "اكتب التقييم",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          pickReviewImage();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add_photo_alternate, color: purple, size: baseUnit * 0.06),
                            const SizedBox(width: 8),
                            IntroSecondText(subtitle: "أرفق صورة", color: purple, size: baseUnit * 0.04),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  /// ====== Pickers (بقي كما هو مع إضافة تصحيح بسيط) ======
  Future<void> pickFile() async {
    final result = await picker.FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: picker.FileType.any,
    );
    if (result != null) {
      setState(() {
        attachments.addAll(result.files);
      });
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        attachments.add(picker.PlatformFile(
          name: img.name,
          path: img.path,
          size: File(img.path).lengthSync(),
        ));
      });
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        attachments.add(picker.PlatformFile(
          name: img.name,
          path: img.path,
          size: File(img.path).lengthSync(),
        ));
      });
    }
  }

  Future<void> pickReviewImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        reviewImages.add(File(img.path));
      });
    }
  }

  /// ====== Helpers ======
  Widget sectionTitle(String title, double baseUnit) {
    return Row(
      children: [
        IntroSecondText(subtitle: title, color: dark, size: baseUnit * 0.045),
        const SizedBox(width: 8),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget infoRow(String icon, String text, double baseUnit) {
    return Row(
      children: [
        Image.asset(icon, height: baseUnit * 0.05),
        const SizedBox(width: 10),
        IntroSecondText(subtitle: text, color: dark, size: baseUnit * 0.04),
      ],
    );
  }

  Widget dottedItem(String image, String text, double baseUnit) {
    return DottedBorder(
      color: Colors.grey,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: baseUnit * 0.08),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: dark,
                fontSize: baseUnit * 0.03,
                fontFamily: 'BahijTheSansArabic',
              ),
            ),
          ],
        ),
      ),
    );
  }
}