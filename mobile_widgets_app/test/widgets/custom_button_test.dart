import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/widgets/custom_button.dart';

void main() {
  testWidgets('Custom button displays its text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: 'Тестова кнопка',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Тестова кнопка'), findsOneWidget);
  });

  testWidgets('Custom button responds to a tap', (
    WidgetTester tester,
  ) async {
    var wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: 'Натисни',
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Натисни'));

    expect(wasPressed, isTrue);
  });
}