import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Style/Colors.dart';
import '../components.dart';

class Filtercolored extends StatefulWidget {
  final Map<String, List<Widget>> filterItems;
  final String? initialFilter;

  const Filtercolored({
    Key? key,
    required this.filterItems,
    this.initialFilter,
  }) : super(key: key);

  @override
  State<Filtercolored> createState() => _FiltercoloredState();
}

class _FiltercoloredState extends State<Filtercolored> {
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialFilter ?? widget.filterItems.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final filters = widget.filterItems.keys.toList();
    final items = widget.filterItems[selectedFilter] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // توسيط الشريط في اللاندسكيب
      children: [
        /// 🔹 شريط الفلاتر
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.02,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isLandscape ? 600 : double.infinity, // عرض الشريط منطقي في اللاندسكيب
              ),
              child: Container(
                height: isLandscape ? size.height * 0.12 : size.height * 0.06,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: List.generate(filters.length, (index) {
                    final isSelected = selectedFilter == filters[index];

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedFilter = filters[index]),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: isSelected ? purple : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            filters[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: isLandscape ? 16 : size.width * 0.038,
                              fontFamily: 'BahijTheSansArabic',
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),

        /// 🔹 المحتوى (قائمة الكروت)
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) => items[index],
          ),
        ),
      ],
    );
  }
}
