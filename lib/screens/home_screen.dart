import 'package:flutter/material.dart';

import '../layout/product_grid.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import '../widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  final Set<int> favoriteIds;
  final ValueChanged<Product> onFavoriteToggle;
  final ValueChanged<Product> onAddToCart;

  const HomeScreen({
    super.key,
    required this.favoriteIds,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _categories = [
    ('Semua', Icons.grid_view_rounded),
    ('Fashion', Icons.checkroom_rounded),
    ('Sepatu', Icons.directions_run_rounded),
    ('Tas', Icons.backpack_rounded),
    ('Elektronik', Icons.headphones_rounded),
    ('Aksesoris', Icons.watch_rounded),
    ('Rumah', Icons.home_rounded),
  ];

  String _query = '';
  String _selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    final visibleProducts = dummyProducts.where((product) {
      final matchesQuery = product.nama.toLowerCase().contains(
        _query.toLowerCase(),
      );
      final matchesCategory =
          _selectedCategory == 'Semua' || product.kategori == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: TokoColors.paleGreen,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.storefront_rounded,
                          color: TokoColors.primary,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TokoKita',
                              style: TextStyle(
                                color: TokoColors.ink,
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Belanja nyaman, setiap hari',
                              style: TextStyle(
                                color: TokoColors.muted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.location_on_outlined,
                        color: TokoColors.primary,
                        size: 19,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Jakarta',
                        style: TextStyle(
                          color: TokoColors.ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Temukan yang kamu suka',
                    style: TextStyle(
                      color: TokoColors.ink,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Pilihan seru dengan harga bersahabat.',
                    style: TextStyle(color: TokoColors.muted, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  SearchField(
                    onChanged: (value) => setState(() => _query = value),
                  ),
                  const SizedBox(height: 18),
                  _buildPromoBanner(),
                  const SizedBox(height: 21),
                  const Text(
                    'Jelajahi kategori',
                    style: TextStyle(
                      color: TokoColors.ink,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _categories.map((category) {
                        return CategoryChip(
                          label: category.$1,
                          icon: category.$2,
                          selected: _selectedCategory == category.$1,
                          onTap: () =>
                              setState(() => _selectedCategory = category.$1),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Pilihan untukmu',
                          style: TextStyle(
                            color: TokoColors.ink,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '${visibleProducts.length} produk',
                        style: const TextStyle(
                          color: TokoColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          if (visibleProducts.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('Produk tidak ditemukan.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = visibleProducts[index];
                  return ProductCard(
                    product: product,
                    isFavorite: widget.favoriteIds.contains(product.id),
                    onFavoritePressed: () => widget.onFavoriteToggle(product),
                    onAddPressed: () => widget.onAddToCart(product),
                  );
                }, childCount: visibleProducts.length),
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

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [TokoColors.primary, TokoColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: TokoColors.primary.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROMO MINGGU INI',
                  style: TextStyle(
                    color: Color(0xFFDCE9FF),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Diskon hingga 30%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Buat harimu makin berwarna',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.local_offer_rounded,
              color: Colors.white,
              size: 31,
            ),
          ),
        ],
      ),
    );
  }
}
