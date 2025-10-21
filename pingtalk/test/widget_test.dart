import 'package:flutter_test/flutter_test.dart';

import 'package:pingtalk/main.dart';

void main() {
  testWidgets('Home screen shows buttons', (tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('마이크 권한 요청'), findsOneWidget);
    expect(find.text('수신 자동 재생 테스트(앱 내)'), findsOneWidget);
  });
}
