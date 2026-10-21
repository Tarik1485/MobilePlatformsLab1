import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/main.dart';

void main() {
  testWidgets('Home screen displays widget library', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MobileWidgetsApp());

    expect(find.text('ібліотека віджетів'), findsOneWidget);
    expect(find.text('еревірити кнопку'), findsOneWidget);
  });
}
