import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/bookings/presentation/controllers/booking_list_controller.dart';

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
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resource Bookings',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Showing ${filteredBookings.length} of ${bookings.length} bookings',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
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
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: filteredBookings.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final booking = filteredBookings[index];
                    return Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        splashColor: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(12),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(0, 0, 0, 0.04),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${booking.resource?.name} | ${booking.bookedFrom.toString().split(' ')[0]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Booked By : ${booking.bookedBy}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.grey.shade600,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Contact : ${booking.contact}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.grey.shade600,
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                      Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Payment',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: Text(
                                                  'COMPLETED',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    backgroundColor: Colors.green,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Status',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: Text(
                                                  'COMPLETED',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    backgroundColor: Colors.green,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Container(
                                //       padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                //       decoration: BoxDecoration(
                                //         color: Colors.green,
                                //         borderRadius: BorderRadius.circular(8)
                                //       ),
                                //       child: Text(
                                //         'PAYMENT COMPLETED',
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //           backgroundColor: Colors.green,
                                //           fontWeight: FontWeight.w900,
                                //           color: Colors.white
                                //         ),
                                //       ),
                                //     ),
                                //     const SizedBox(height: 5),
                                //     Container(
                                //       padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                //       decoration: BoxDecoration(
                                //         color: Colors.green,
                                //         borderRadius: BorderRadius.circular(8)
                                //       ),
                                //       child: Text(
                                //         'PAYMENT COMPLETED',
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //           backgroundColor: Colors.green,
                                //           fontWeight: FontWeight.w900,
                                //           color: Colors.white
                                //         ),
                                //       ),
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading members')),
    );
  }
}
