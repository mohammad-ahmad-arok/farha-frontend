import 'package:flutter/material.dart';
import '../../Style/Colors.dart';
import '../components.dart';

class Todolistfilter extends StatefulWidget {
  final Map<String, List<Widget>> filterItems;
  final String initialFilter;
  final Function(String)? onFilterChanged;

  const Todolistfilter({
    super.key,
    required this.filterItems,
    required this.initialFilter,
    this.onFilterChanged,
  });

  @override
  State<Todolistfilter> createState() => _TodolistfilterState();
}

class _TodolistfilterState extends State<Todolistfilter> {
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final filters = widget.filterItems.keys.toList();
    final items = widget.filterItems[selectedFilter] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 شريط الفلاتر
        Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Container(
            width: double.infinity,
            // نستخدم Center هنا فقط عند الـ Landscape لتوسيط العناصر
            alignment: isLandscape ? Alignment.center : Alignment.centerRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // physics تجعل التمرير يبدو طبيعياً حتى لو كانت العناصر بالمنتصف
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min, // يمنع الـ Row من أخذ عرض الشاشة كاملاً
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(filters.length, (index) {
                  final isSelected = selectedFilter == filters[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filters[index];
                        });
                        widget.onFilterChanged?.call(filters[index]);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: isLandscape ? 6 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? purple : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: IntroSecondText(
                          subtitle: filters[index],
                          color: isSelected ? Colors.white : Colors.black,
                          size: isLandscape ? size.width * 0.025 : size.width * 0.037,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// 🔹 المحتوى
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            children: items,
          ),
        ),
      ],
    );
  }
}