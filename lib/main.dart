import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/cart_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TokoKitaApp());
}

class TokoKitaApp extends StatelessWidget {
  const TokoKitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TokoKita',
      debugShowCheckedModeBanner: false,
      theme: TokoTheme.light,
      home: const StoreShell(),
    );
  }
}

class StoreShell extends StatefulWidget {
  const StoreShell({super.key});

  @override
  State<StoreShell> createState() => _StoreShellState();
}

class _StoreShellState extends State<StoreShell> {
  int _selectedIndex = 0;
  final Set<int> _favoriteIds = {};
  final Map<int, int> _cartQuantities = {};

  void _toggleFavorite(Product product) {
    setState(() {
      if (!_favoriteIds.add(product.id)) {
        _favoriteIds.remove(product.id);
      }
    });
  }

  void _addToCart(Product product) {
    setState(() {
      _cartQuantities.update(
        product.id,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.nama} ditambahkan ke keranjang'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _changeQuantity(Product product, int difference) {
    setState(() {
      final updatedQuantity = (_cartQuantities[product.id] ?? 0) + difference;
      if (updatedQuantity <= 0) {
        _cartQuantities.remove(product.id);
      } else {
        _cartQuantities[product.id] = updatedQuantity;
      }
    });
  }

  void _checkout() {
    setState(_cartQuantities.clear);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesanan berhasil dibuat. Terima kasih!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = dummyProducts
        .where((product) => _favoriteIds.contains(product.id))
        .toList();
    final cartProducts = dummyProducts
        .where((product) => _cartQuantities.containsKey(product.id))
        .toList();

    final screens = [
      HomeScreen(
        favoriteIds: _favoriteIds,
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      FavoritesScreen(
        products: favoriteProducts,
        favoriteIds: _favoriteIds,
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      CartScreen(
        products: cartProducts,
        quantities: _cartQuantities,
        onQuantityChange: _changeQuantity,
        onCheckout: _checkout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_border_rounded),
            selectedIcon: const Icon(Icons.favorite_rounded),
            label: 'Favorit',
            tooltip: '${favoriteProducts.length} produk favorit',
          ),
          NavigationDestination(
            icon: const Icon(Icons.shopping_bag_outlined),
            selectedIcon: const Icon(Icons.shopping_bag_rounded),
            label: 'Keranjang',
            tooltip:
                '${_cartQuantities.values.fold<int>(0, (a, b) => a + b)} barang',
          ),
        ],
      ),
    );
  }
}
