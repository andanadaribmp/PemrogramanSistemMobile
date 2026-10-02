import 'package:flutter/material.dart';

import '../models/product.dart';
import 'category_tag.dart';
import 'price_label.dart';
import 'stock_badge.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  // Progress bar stok mengikuti status: tersedia penuh, terbatas setengah,
  // habis nyaris kosong.
  double _fracStok(StockStatus status) {
    switch (status) {
      case StockStatus.tersedia:
        return 0.85;
      case StockStatus.terbatas:
        return 0.45;
      case StockStatus.habis:
        return 0.08;
    }
  }

  Color _warnaStok(StockStatus status) {
    switch (status) {
      case StockStatus.tersedia:
        return const Color(0xFF00A83B);
      case StockStatus.terbatas:
        return Colors.orange;
      case StockStatus.habis:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // GAMBAR PRODUK (BAGIAN ATAS)
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: const Color(0xFFF2F4F5),
                      child: Icon(
                        product.icon,
                        size: 64,
                        color: const Color(0xFF00A83B),
                      ),
                    ),
                  ),

                  // BADGE DISKON: KIRI ATAS
                  if (product.diskon != null)
                    Positioned(
                      top: 8,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${product.diskon}% OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // BADGE STOK: KIRI BAWAH
                  Positioned(
                    bottom: 8,
                    left: 6,
                    child: StockBadge(
                      status: product.stockStatus,
                    ),
                  ),
                ],
              ),
            ),

            // INFORMASI PRODUK (BAGIAN BAWAH)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag kategori dan ikon favorit sejajar horizontal.
                  Row(
                    children: [
                      CategoryTag(
                        kategori: product.kategori,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF303030),
                    ),
                  ),

                  const SizedBox(height: 6),

                  PriceLabel(
                    harga: product.harga,
                    hargaCoret: product.hargaCoret,
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 13,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${product.terjual}+ terjual',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // INDIKATOR STOK: BARIS PROGRES DI BAWAH
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _fracStok(product.stockStatus),
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(
                        _warnaStok(product.stockStatus),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
