import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CategoryTag extends StatelessWidget {
  final String kategori;

  const CategoryTag({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: TokoColors.paleGreen,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        kategori,
        style: const TextStyle(
          fontSize: 10,
          color: TokoColors.primaryDark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
