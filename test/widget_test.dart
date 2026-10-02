
import 'package:flutter_test/flutter_test.dart';

import 'package:tokokita/main.dart';

void main() {
  testWidgets('TokoKitaApp menampilkan judul AppBar', (
    WidgetTester tester,
  ) async {
    // Build aplikasi dan trigger satu frame.
    await tester.pumpWidget(const TokoKitaApp());

    // Verifikasi judul "TokoKita" muncul di AppBar.
    expect(find.text('TokoKita'), findsOneWidget);
  });
}
