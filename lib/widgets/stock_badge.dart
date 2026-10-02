import 'package:flutter/material.dart';
import '../models/product.dart';

class StockBadge extends StatelessWidget {
  final StockStatus status;

  const StockBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;

    switch (status) {
      case StockStatus.tersedia:
        text = 'Tersedia';
        color = const Color(0xFF00A83B);
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
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}