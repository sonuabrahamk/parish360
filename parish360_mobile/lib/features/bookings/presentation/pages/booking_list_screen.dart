import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/features/bookings/presentation/controllers/booking_list_controller.dart';
import 'package:parish360_mobile/features/bookings/presentation/pages/bookings_screen.dart';
import 'package:parish360_mobile/features/bookings/presentation/widgets/bookings_card.dart';

class BookingListScreen extends ConsumerStatefulWidget {
  const BookingListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookingListScreenState();
}

class _BookingListScreenState extends ConsumerState<BookingListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(bookingSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingsAsync = ref.watch(bookingListControllerProvider('resource'));
    final searchQuery = ref.watch(bookingSearchQueryProvider);
    final filteredBookings = ref.watch(
      filteredBookingInfoListProvider(searchQuery, 'resource'),
    );

    return bookingsAsync.when(
      data: (bookings) => SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              bookings.isEmpty
                  ? ListTitle(
                      module: 'bookings',
                      subTitle: 'No booking records found',
                      title: 'Resource Bookings',
                      onCreatePressed: onCreatePressed,
                    )
                  : ListTitle(
                      module: 'bookings',
                      subTitle:
                          'Showing ${filteredBookings.length} of ${bookings.length} bookings',
                      title: 'Resource Bookings',
                      onCreatePressed: onCreatePressed,
                    ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    ref.read(bookingSearchQueryProvider.notifier).update(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search bookings ...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: filteredBookings.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final booking = filteredBookings[index];
                    return BookingsCard(booking: booking);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading Resource Bookings')),
    );
  }

  void onCreatePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingsScreen()),
    );
  }
}
