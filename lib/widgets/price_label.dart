import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

class PriceLabel extends StatelessWidget {
  final int harga;
  final int? hargaCoret;

  const PriceLabel({super.key, required this.harga, this.hargaCoret});

  String formatRupiah(int value) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatRupiah(harga),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: TokoColors.primaryDark,
          ),
        ),
        if (hargaCoret != null)
          Text(
            formatRupiah(hargaCoret!),
            style: const TextStyle(
              fontSize: 10,
              color: TokoColors.muted,
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }
}
