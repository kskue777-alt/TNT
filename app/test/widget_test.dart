import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:tnt/main.dart';

void main() {
  testWidgets('renders push to talk tab', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PushToTalkController(),
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.text('푸쉬앤토크'), findsOneWidget);
  });
}
