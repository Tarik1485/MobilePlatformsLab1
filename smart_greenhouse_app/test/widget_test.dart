import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_greenhouse_app/main.dart';

void main() {
  testWidgets(
    'Застосунок розумної теплиці запускається',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(const GreenhouseApp());

        await Future<void>.delayed(
          const Duration(milliseconds: 2500),
        );

        await tester.pump();
      });

      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}