import 'package:flutter/material.dart';

class CategoryLabel extends StatelessWidget {
  final String category;
  final Color tagColor;
  final Color tagBgColor;

  const CategoryLabel({
    super.key,
    required this.category,
    required this.tagColor,
    required this.tagBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: tagBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: tagColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
