import 'package:flutter/material.dart';

import '../layout/product_grid.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Product> products;
  final Set<int> favoriteIds;
  final ValueChanged<Product> onFavoriteToggle;
  final ValueChanged<Product> onAddToCart;

  const FavoritesScreen({
    super.key,
    required this.products,
    required this.favoriteIds,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Favorit',
                    style: TextStyle(
                      color: TokoColors.ink,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    products.isEmpty
                        ? 'Simpan produk yang ingin kamu lihat lagi.'
                        : '${products.length} produk yang kamu suka',
                    style: const TextStyle(
                      color: TokoColors.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (products.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: _EmptyFavorites(),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    isFavorite: favoriteIds.contains(product.id),
                    onFavoritePressed: () => onFavoriteToggle(product),
                    onAddPressed: () => onAddToCart(product),
                  );
                }, childCount: products.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: productGridColumnCount(
                    MediaQuery.sizeOf(context).width,
                  ),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

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
                Icons.favorite_border_rounded,
                color: TokoColors.primary,
                size: 42,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Belum ada favorit',
              style: TextStyle(
                color: TokoColors.ink,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Ketuk ikon hati pada produk untuk menyimpannya di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(color: TokoColors.muted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
