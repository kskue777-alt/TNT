import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tnt/main.dart';

void main() {
  testWidgets('Hello TNT text is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const TntApp());

    expect(find.text('Hello TNT'), findsNWidgets(2));
    expect(find.byType(AppBar), findsOneWidget);
  });
}
