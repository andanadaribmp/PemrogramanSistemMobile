import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tokokita/layout/product_grid.dart';
import 'package:tokokita/main.dart';

void main() {
  test('grid menampilkan 5 hingga 7 kartu per baris di layar lebar', () {
    expect(productGridColumnCount(1024), 5);
    expect(productGridColumnCount(1366), 6);
    expect(productGridColumnCount(1600), 7);
  });

  testWidgets('aplikasi menampilkan beranda dan navigasi tiga layar', (
    tester,
  ) async {
    await tester.pumpWidget(const TokoKitaApp());

    expect(find.text('TokoKita'), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Favorit'), findsOneWidget);
    expect(find.text('Keranjang'), findsOneWidget);

    await tester.tap(find.text('Favorit'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada favorit'), findsOneWidget);

    await tester.tap(find.text('Keranjang'));
    await tester.pumpAndSettle();
    expect(find.text('Keranjang masih kosong'), findsOneWidget);
  });

  testWidgets('produk dapat ditambahkan ke favorit dan keranjang', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const TokoKitaApp());

    await tester.tap(find.byIcon(Icons.favorite_border_rounded).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Favorit'));
    await tester.pumpAndSettle();
    expect(find.text('1 produk yang kamu suka'), findsOneWidget);

    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(CustomScrollView).first,
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tambah').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Keranjang'));
    await tester.pumpAndSettle();
    expect(find.text('1 barang pilihanmu'), findsOneWidget);
    expect(find.text('Kaos Polos Premium Hitam'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('2 barang pilihanmu'), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut checkout'));
    await tester.pumpAndSettle();
    expect(find.text('Pesanan berhasil dibuat. Terima kasih!'), findsOneWidget);
  });
}
