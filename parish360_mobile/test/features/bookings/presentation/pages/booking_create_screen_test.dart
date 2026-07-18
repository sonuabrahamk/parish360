import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parish360_mobile/features/bookings/presentation/pages/booking_create_screen.dart';

void main() {
  testWidgets('renders the booking creation flow shell', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: BookingCreateScreen()),
      ),
    );

    expect(find.text('Create booking'), findsAtLeastNWidgets(1));
    expect(find.text('Select your dates'), findsOneWidget);
  });
}
