import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/bookings/presentation/pages/booking_list_screen.dart';
import 'package:parish360_mobile/features/bookings/presentation/pages/service_intention_list_screen.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          isScrollable: false,
          tabAlignment: TabAlignment.fill,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          tabs: [
            Tab(icon: Icon(Icons.inventory_2), text: 'Resources'),
            Tab(icon: Icon(Icons.self_improvement), text: 'Service Intentions'),
          ],
        ),
        body: TabBarView(
          children: [BookingListScreen(), ServiceIntentionListScreen()],
        ),
      ),
    );
  }
}
