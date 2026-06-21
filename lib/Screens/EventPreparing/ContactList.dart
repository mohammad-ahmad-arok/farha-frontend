
import 'package:flutter/material.dart' hide SearchBar;
import 'package:url_launcher/url_launcher.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> services = [
    {
      'name': 'خدمة صيانة مكيفات',
      'phone': '966501234567',
      'image': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'name': 'خدمة تنظيف منازل',
      'phone': '966509876543',
      'image': 'https://i.pravatar.cc/150?img=2',
    },
    {
      'name': 'خدمة كهرباء',
      'phone': '966512345678',
      'image': 'https://i.pravatar.cc/150?img=3',
    },
  ];

  void openWhatsApp(String phone) async {
    final Uri url = Uri.parse("https://wa.me/$phone");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:Column(
        children: [
          // AppBarEventDetails(context, "اسم مقدم الخدمة"),
          // SizedBox(height:30,),
        ],
      ),
    );
  }
}