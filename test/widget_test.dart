
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/home/repositories/deal_repository.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/home/providers/deal_provider.dart';
import 'package:myapp/main.dart';
import 'package:myapp/firebase_options.dart';

// Helper to initialize firebase
Future<void> setupFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Already initialized
  }
}

void main() {
  // Ensure firebase is initialized before running tests
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await setupFirebase();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => DealProvider(
              DealRepository(),
            ),
          ),
        ],
        child: const DealDiverApp(),
      ),
    );

    // Let the widget tree build
    await tester.pumpAndSettle();

    // Verify that the AppBar title is 'Deal Diver'.
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Deal Diver'), findsOneWidget);
  });
}
