import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/main.dart';

void main() {
  group('Pet Adoption App Tests', () {
    testWidgets('Pet Adoption App Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Pet Adoption'), findsOneWidget);
      expect(find.byType(ListTile), findsWidgets);

      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      expect(find.byType(DetailsScreen), findsOneWidget);
      expect(find.text('Fluffy'), findsOneWidget);
      expect(find.text('2 years old - \$100'), findsOneWidget);

      await tester.tap(find.text('Adopt Me'));
      await tester.pumpAndSettle();

      expect(find.text('You’ve now adopted Fluffy'), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text('Already Adopted'), findsOneWidget);

      await tester.tap(find.byKey(const Key('history_page')));
      await tester.pumpAndSettle();

      expect(find.text('Fluffy'), findsOneWidget);
    });

    testWidgets('Test Zoom Feature in DetailsScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Hero));
      await tester.pumpAndSettle();

      expect(find.byType(InteractiveViewer), findsOneWidget);

      await tester.pinch(find.byType(InteractiveViewer));
      await tester.pumpAndSettle();

      // Add assertions for zoom behavior.
      // For example, you can check the scale factor or image size.
    });

    // Add more test suites as needed...
  });
}
