import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';

class EditorScreen extends StatefulWidget {
  final String imagePath;
  const EditorScreen({super.key, required this.imagePath});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final GlobalKey repaintKey = GlobalKey();
  final TextEditingController editController = TextEditingController();

  List<TextItem> texts = [];
  int selectedIndex = 0;

  final List<String> fontFamilies = [
    'Cairo', 'BahijTheSansArabic', 'Amiri', 'ArefRuqaa',
    'ElMessiri', 'Lateef', 'Mada', 'Mirza',
    'MarkaziText', 'ReemKufi', 'Tajawal',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addNewText();
    });
  }

  Future<bool> requestStoragePermission() async {
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLandscape = screenSize.width > screenSize.height;

    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        backgroundColor: light,
        elevation: 0,
        title: IntroSecondText(subtitle: "تصميم الكرت", size: 16, color: dark),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: purple),
            onPressed: () async {
              bool ok = await requestStoragePermission();
              if (!ok) {
                _showSnackBar('لا يوجد إذن للوصول للصور', Colors.red);
                return;
              }
              saveCardAsImage(repaintKey, context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: FractionallySizedBox(
                    // تصغير الصورة في الروتيت لتصبح 70% من عرض الشاشة بدلاً من 100%
                    widthFactor: isLandscape ? 0.7 : 0.9,
                    child: RepaintBoundary(
                      key: repaintKey,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(widget.imagePath, fit: BoxFit.contain),
                          ...texts.asMap().entries.map((entry) {
                            int i = entry.key;
                            TextItem item = entry.value;
                            return Positioned(
                              left: item.position.dx,
                              top: item.position.dy,
                              child: GestureDetector(
                                onTap: () => setState(() => selectedIndex = i),
                                onPanUpdate: (details) {
                                  setState(() {
                                    item.position += details.delta;
                                  });
                                },
                                child: Text(
                                  item.text,
                                  style: TextStyle(
                                    fontSize: item.fontSize,
                                    color: item.color,
                                    fontFamily: item.fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: light,
        elevation: 8,
        child: Container(
          height: 60,
          width: double.infinity,
          alignment: Alignment.center, // سنترة المحتوى بالمنتصف
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // سنترة الأيقونات
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBottomNavItem(icon: Icons.add, label: 'إضافة', onTap: addNewText),
                _buildBottomNavItem(icon: Icons.format_size, label: 'الحجم', onTap: () => _showFontSizeBottomSheet(screenSize.width, screenSize.height)),
                _buildBottomNavItem(icon: Icons.palette, label: 'اللون', onTap: () => _showColorBottomSheet(screenSize.width, screenSize.height)),
                _buildBottomNavItem(icon: Icons.font_download, label: 'الخط', onTap: () => _showFontFamilyBottomSheet(screenSize.width, screenSize.height)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: dark, size: 26),
            const SizedBox(height: 2),
            IntroSecondText(subtitle: label, color: dark, size: 11),
          ],
        ),
      ),
    );
  }


  void addNewText() {
    final Size screenSize = MediaQuery.of(context).size;
    setState(() {
      texts.add(TextItem(
        position: Offset(50, 100),
        text: "",
        fontFamily: texts.isNotEmpty ? texts[selectedIndex].fontFamily : 'Cairo',
      ));
      selectedIndex = texts.length - 1;
    });
    _showAddTextBottomSheet(screenSize.width, screenSize.height);
  }

  void _showAddTextBottomSheet(double screenWidth, double screenHeight) {
    editController.text = texts[selectedIndex].text;
    final bool isLandscape = screenWidth > screenHeight;
    final double sheetHeight = isLandscape ? screenHeight * 0.8 : screenHeight * 0.55;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: sheetHeight,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        // تعديل الـ Padding السفلي ليكون 5 فقط في الروتيت
        padding: EdgeInsets.fromLTRB(
            screenWidth * 0.05,
            screenHeight * 0.02,
            screenWidth * 0.05,
            isLandscape ? 5 : screenHeight * 0.05
        ),
        child: Column(
          children: [
            Center(child: Container(width: screenWidth * 0.1, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            SizedBox(height: screenHeight * 0.02),
            IntroSecondText(subtitle: "إضافة نص جديد", color: dark, size: 18),
            const Divider(),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: TextField(
                controller: editController,
                textAlign: TextAlign.right,
                maxLines: isLandscape ? 3 : 5,
                decoration: InputDecoration(
                  hintText: 'أدخل النص هنا',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: EdgeInsets.all(screenWidth * 0.03),
                ),
              ),
            ),
            // إزالة المسافة في الروتيت لتقليل الفراغ تحت الأزرار
            if (!isLandscape) SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () { setState(() => texts[selectedIndex].text = editController.text); Navigator.pop(context); },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: purple,
                            minimumSize: Size(double.infinity, isLandscape ? screenHeight * 0.12 : screenHeight * 0.06),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                        ),
                        child: IntroSecondText(subtitle: "حفظ", color: light, size: 14)
                    )
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                    child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, isLandscape ? screenHeight * 0.12 : screenHeight * 0.06),
                            side: const BorderSide(color: purple),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                        ),
                        child: IntroSecondText(subtitle: "إلغاء", color: purple, size: 14)
                    )
                ),
              ],
            ),
            if (isLandscape) const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
  void _showFontSizeBottomSheet(double screenWidth, double screenHeight) {
    if (texts.isEmpty) return;
    final item = texts[selectedIndex];
    final bool isLandscape = screenWidth > screenHeight;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        double tempFontSize = item.fontSize;
        return StatefulBuilder(
          builder: (context, setSheetState) => Container(
            height: isLandscape ? screenHeight * 0.8 : screenHeight * 0.45,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05,
                screenHeight * 0.02,
                screenWidth * 0.05,
                isLandscape ? 5 : screenHeight * 0.02
            ),
            child: Column(
              children: [
                Center(child: Container(width: screenWidth * 0.1, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
                SizedBox(height: screenHeight * 0.02),
                Align(alignment: Alignment.topRight, child: IntroSecondText(subtitle: "تغيير حجم الخط", color: dark, size: 18)),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: isLandscape ? screenHeight * 0.2 : screenHeight * 0.12,
                          alignment: Alignment.center,
                          child: Text('معاينة', style: TextStyle(fontSize: tempFontSize, fontFamily: item.fontFamily, color: item.color)),
                        ),
                        Slider(
                          activeColor: purple,
                          value: tempFontSize,
                          min: 12, max: 80,
                          onChanged: (v) {
                            setSheetState(() => tempFontSize = v);
                            setState(() => item.fontSize = v);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLandscape) SizedBox(height: screenHeight * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    minimumSize: Size(double.infinity, isLandscape ? screenHeight * 0.12 : screenHeight * 0.06),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: IntroSecondText(subtitle: 'تم', color: light, size: 16),
                ),
                if (isLandscape) const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }  void _showColorBottomSheet(double screenWidth, double screenHeight) {
    if (texts.isEmpty) return;
    final item = texts[selectedIndex];
    final bool isLandscape = screenWidth > screenHeight;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: isLandscape ? screenHeight * 0.85 : screenHeight * 0.65,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          children: [
            Center(child: Container(width: screenWidth * 0.1, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            SizedBox(height: screenHeight * 0.02),
            IntroSecondText(subtitle: "تغيير لون الخط", color: dark, size: 18),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isLandscape ? screenWidth * 0.1 : 0, vertical: screenHeight * 0.01),
                  child: ColorPicker(
                    pickerColor: item.color,
                    onColorChanged: (color) => setState(() => item.color = color),
                    enableAlpha: false,
                    displayThumbColor: true,
                    pickerAreaHeightPercent: isLandscape ? 0.4 : 0.7,
                    paletteType: PaletteType.hsvWithHue,
                    labelTypes: const [],
                    portraitOnly: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                // زيادة الطول لتسهيل الاستخدام في وضع الـ Landscape
                minimumSize: Size(double.infinity, isLandscape ? screenHeight * 0.1 : screenHeight * 0.06),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => Navigator.pop(context),
              child: IntroSecondText(subtitle: 'تم', color: light, size: 14),
            ),          ],
        ),
      ),
    );
  }

  void _showFontFamilyBottomSheet(double screenWidth, double screenHeight) {
    if (texts.isEmpty) return;
    final item = texts[selectedIndex];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: screenHeight * 0.5,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        padding: EdgeInsets.only(top: screenHeight * 0.02),
        child: Column(
          children: [
            Center(child: Container(width: screenWidth * 0.1, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            SizedBox(height: screenHeight * 0.01),
            IntroSecondText(subtitle: "اختر نوع الخط", color: dark, size: 16),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: fontFamilies.length,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                itemBuilder: (context, index) => ListTile(
                  title: Text(fontFamilies[index], textAlign: TextAlign.center, style: TextStyle(fontFamily: fontFamilies[index], fontSize: 18)),
                  selected: item.fontFamily == fontFamilies[index],
                  selectedColor: purple,
                  onTap: () { setState(() => item.fontFamily = fontFamilies[index]); Navigator.pop(context); },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: color));
  }

  Future<void> saveCardAsImage(GlobalKey repaintKey, BuildContext context) async {
    try {
      final boundary = repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/card_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(pngBytes);
      await Gal.putImage(file.path);
      _showSnackBar('تم الحفظ بنجاح', Colors.green);
    } catch (e) {
      _showSnackBar('فشل الحفظ', Colors.red);
    }
  }
}

class TextItem {
  Offset position;
  String text;
  double fontSize;
  Color color;
  String fontFamily;
  TextItem({required this.position, required this.text, this.fontSize = 22, this.color = Colors.black, this.fontFamily = 'Cairo'});
}