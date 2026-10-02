import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';

class StockBadge extends StatelessWidget {
  final StockStatus status;

  const StockBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;

    switch (status) {
      case StockStatus.tersedia:
        text = 'Tersedia';
        color = TokoColors.success;
        break;

      case StockStatus.terbatas:
        text = 'Terbatas';
        color = Colors.orange;
        break;

      case StockStatus.habis:
        text = 'Habis';
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
