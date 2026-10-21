import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:college_library_app/main.dart';
import 'package:college_library_app/models/auth_model.dart';
import 'package:college_library_app/models/library_model.dart';

void main() {
  testWidgets('Застосунок бібліотеки запускається', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthModel()),
          ChangeNotifierProvider(create: (_) => LibraryModel()),
        ],
        child: const LibraryApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Каталог'), findsWidgets);
    expect(find.text('Мої книги'), findsOneWidget);
    expect(find.text('Профіль'), findsOneWidget);
  });
}