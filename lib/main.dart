
import 'package:flutter/material.dart';
import 'models/product.dart';
import 'widgets/product_card.dart';
 
void main() {
  runApp(const TokoKitaApp());
}
 
class TokoKitaApp extends StatelessWidget {
  const TokoKitaApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TokoKita',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF5F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}
 
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Tentukan jumlah kolom berdasarkan lebar layar, biar kartu gak
  // raksasa di desktop tapi tetap nyaman di HP.
  int _hitungJumlahKolom(double lebarLayar) {
    if (lebarLayar >= 1200) return 6;
    if (lebarLayar >= 900) return 5;
    if (lebarLayar >= 700) return 4;
    if (lebarLayar >= 480) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TokoKita')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final int jumlahKolom = _hitungJumlahKolom(constraints.maxWidth);

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: jumlahKolom,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              // Kartu vertikal: lebih tinggi dari lebar, gambar di atas
              // dan info di bawah.
              childAspectRatio: 0.72,
            ),
            itemCount: dummyProducts.length, 
            itemBuilder: (context, index) {
            final product = dummyProducts[index];              // Setiap ProductCard punya State-nya masing-masing,
              // sehingga status favorit tiap kartu independen satu sama lain.
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}
 