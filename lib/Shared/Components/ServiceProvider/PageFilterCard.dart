import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Style/Colors.dart';
import '../components.dart';

class FilterWidget extends StatefulWidget {
  final Map<String, List<Widget>> filterItems;
  final String? initialFilter;

  const FilterWidget({
    Key? key,
    required this.filterItems,
    this.initialFilter,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  // تعريف المتغير المفقود
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    // تهيئة القيمة المختارة
    selectedFilter = widget.initialFilter ?? widget.filterItems.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final filters = widget.filterItems.keys.toList();
    final items = widget.filterItems[selectedFilter] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 شريط الفلاتر المتجاوب
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: isLandscape ? 4 : size.width * 0.03,
          ),
          child: Container(
            width: double.infinity,
            height: isLandscape ? size.height * 0.12 : size.height * 0.055,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: filters.map((filterName) {
                final isSelected = selectedFilter == filterName;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filterName;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected ? purple : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: IntroSecondText(
                        subtitle: filterName,
                        color: isSelected ? Colors.white : Colors.black,
                        size: isLandscape ? size.width * 0.025 : size.width * 0.035,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        const SizedBox(height: 5),

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