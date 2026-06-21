// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'EventPage.dart';
// import 'SortPage.dart';
//
// class Filterpageview extends StatefulWidget {
//   final Map<String, bool> initialEventSelections;
//
//   const Filterpageview({
//     super.key,
//     this.initialEventSelections = const {},
//   });
//
//   @override
//   State<Filterpageview> createState() => _FilterpageviewState();
// }
//
// class _FilterpageviewState extends State<Filterpageview> {
//   late Map<String, bool> eventSelections;
//   final PageController _pageController = PageController();
//
//   @override
//   void initState() {
//     super.initState();
//     eventSelections = Map.from(widget.initialEventSelections);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('التصفية والترتيب'),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // إعادة النتيجة عند الضغط على تم
//               Navigator.pop(context, eventSelections);
//             },
//             child: const Text('تم'),
//           ),
//         ],
//       ),
//       body: PageView(
//         controller: _pageController,
//         children: [
//           Sortpage(), // تأكد من أن Sortpage لها هيكل مناسب
//           Eventpage(
//             initialSelections: eventSelections,
//             onChanged: (newSelections) {
//               // تحديث الحالة في Filterpageview عند تغيير الاختيارات
//               setState(() {
//                 eventSelections = newSelections;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }