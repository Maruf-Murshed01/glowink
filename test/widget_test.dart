// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bduink/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Setup Firebase Core mocks
    setupFirebaseCoreMocks();
    await Firebase.initializeApp();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

void setupFirebaseCoreMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Setup method channel mock
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/firebase_core');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'Firebase#initializeCore':
        return [
          {
            'name': '[DEFAULT]',
            'options': {
              'apiKey': 'AIzaSyDqPN7LIhws6Kd1enRnTCryHCsOKJwUYpg',
              'appId': '1:362537266257:android:8b61d2a17fe614ef175c70',
              'messagingSenderId': '362537266257',
              'projectId': 'glowink-f908a',
            },
            'pluginConstants': {},
          }
        ];
      case 'Firebase#initializeApp':
        return {
          'name': '[DEFAULT]',
          'options': {
            'apiKey': 'AIzaSyDqPN7LIhws6Kd1enRnTCryHCsOKJwUYpg',
            'appId': '1:362537266257:android:8b61d2a17fe614ef175c70',
            'messagingSenderId': '362537266257',
            'projectId': 'glowink-f908a',
          },
          'pluginConstants': {},
        };
      default:
        return null;
    }
  });
}
