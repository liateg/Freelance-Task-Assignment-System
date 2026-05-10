import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';

void main() {
  testWidgets('app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ReClaimApp());
    await tester.pump();
    expect(find.byType(ReClaimApp), findsOneWidget);
  });
}
