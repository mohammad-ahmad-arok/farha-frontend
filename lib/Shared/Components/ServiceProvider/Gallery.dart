import 'package:flutter/material.dart';

import '../../Style/Colors.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=500&q=80', // طبيعة
    'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=500&q=80', // مدن
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=500&q=80', // سفر
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=500&q=80', // مناظر خلابة
    'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=500&q=80', // غابات
  ];
  void openImageDialog(int initialIndex) {
    int currentIndex = initialIndex;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // الصورة الكبيرة
                  Container(
                    width:353,
                    height:315,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Image.network(
                      imageUrls[currentIndex],
                      fit: BoxFit.contain,
                    ),
                  ),

                  // السهم اليسار
                  Positioned(
                    left: 0,
                    child: Container(
                      width:40,
                      height:40,
                      decoration:BoxDecoration(
                        shape:BoxShape.circle,
                        color:light
                      ),
                      child: IconButton(
                        iconSize: 20,
                        color:purple,
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () {
                          setState(() {
                            currentIndex =
                                (currentIndex - 1 + imageUrls.length) %
                                    imageUrls.length;
                          });
                        },
                      ),
                    ),
                  ),

                  // السهم اليمين
                  Positioned(
                    right: 0,
                    child: Container(
                      width:40,
                      height:40,
                      decoration:BoxDecoration(
                          shape:BoxShape.circle,
                          color:light
                      ),
                      child: IconButton(
                        iconSize:20,
                        color:purple,
                        icon: Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () {
                          setState(() {
                            currentIndex =
                                (currentIndex + 1) % imageUrls.length;
                          });
                        },
                      ),
                    ),
                  ),

                  // زر إغلاق
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GestureDetector(
                onTap: () => openImageDialog(index),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
