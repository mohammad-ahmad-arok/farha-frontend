
import 'package:flutter/material.dart';

import '../../Shared/Components/EventDetails/EventDetailsComponents.dart';

class Theday extends StatefulWidget {
  const Theday({super.key});

  @override
  State<Theday> createState() => _ThedayState();
}

class _ThedayState extends State<Theday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarEventDetails(context, "تفاصيل الحدث", showLeftButton: true,showTime:true,time:"45"),
              ],
      ),
    );
  }
}
