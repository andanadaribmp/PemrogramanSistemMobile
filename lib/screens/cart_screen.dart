import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

class CartScreen extends StatelessWidget {
  final List<Product> products;
  final Map<int, int> quantities;
  final void Function(Product product, int difference) onQuantityChange;
  final VoidCallback onCheckout;

  const CartScreen({
    super.key,
    required this.products,
    required this.quantities,
    required this.onQuantityChange,
    required this.onCheckout,
  });

  String _formatRupiah(int value) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(value);
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = products.fold<int>(
      0,
      (total, product) => total + product.harga * (quantities[product.id] ?? 0),
    );

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Keranjang',
                  style: TextStyle(
                    color: TokoColors.ink,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${quantities.values.fold<int>(0, (a, b) => a + b)} barang pilihanmu',
                  style: const TextStyle(color: TokoColors.muted, fontSize: 13),
                ),
              ],
            ),
          ),
          if (products.isEmpty)
            const Expanded(child: _EmptyCart())
          else ...[
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: products.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _CartItem(
                    product: product,
                    quantity: quantities[product.id] ?? 0,
                    onDecrease: () => onQuantityChange(product, -1),
                    onIncrease: () => onQuantityChange(product, 1),
                    formatRupiah: _formatRupiah,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: TokoColors.border)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Subtotal',
                          style: TextStyle(
                            color: TokoColors.muted,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        _formatRupiah(subtotal),
                        style: const TextStyle(
                          color: TokoColors.ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: 'Lanjut checkout',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: onCheckout,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final String Function(int) formatRupiah;

  const _CartItem({
    required this.product,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    required this.formatRupiah,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: TokoColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 78,
            width: 78,
            decoration: BoxDecoration(
              color: TokoColors.paleGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(product.icon, color: TokoColors.primary, size: 35),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.nama,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: TokoColors.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  formatRupiah(product.harga),
                  style: const TextStyle(
                    color: TokoColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _QuantityButton(icon: Icons.remove, onPressed: onDecrease),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          color: TokoColors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _QuantityButton(icon: Icons.add, onPressed: onIncrease),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: TokoColors.paleGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: TokoColors.primary),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 88,
              width: 88,
              decoration: BoxDecoration(
                color: TokoColors.paleGreen,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: TokoColors.primary,
                size: 42,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Keranjang masih kosong',
              style: TextStyle(
                color: TokoColors.ink,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Yuk, temukan produk menarik di halaman Beranda.',
              textAlign: TextAlign.center,
              style: TextStyle(color: TokoColors.muted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
