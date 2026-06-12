import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/features/bookings/presentation/controllers/booking_list_controller.dart';
import 'package:parish360_mobile/features/bookings/presentation/pages/bookings_screen.dart';
import 'package:parish360_mobile/features/bookings/presentation/widgets/intentions_card.dart';

class ServiceIntentionListScreen extends ConsumerStatefulWidget {
  const ServiceIntentionListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceIntentionListScreenState();
}

class _ServiceIntentionListScreenState
    extends ConsumerState<ServiceIntentionListScreen> {
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
    final intentionsAsync = ref.watch(
      bookingListControllerProvider('service-intention'),
    );
    final searchQuery = ref.watch(bookingSearchQueryProvider);
    final filteredIntentions = ref.watch(
      filteredBookingInfoListProvider(searchQuery, 'service-intention'),
    );

    return intentionsAsync.when(
      data: (intentions) => SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              intentions.isEmpty
                  ? ListTitle(
                      module: 'bookings',
                      subTitle: 'No booking records found',
                      title: 'Resource Bookings',
                      onCreatePressed: onCreatePressed,
                    )
                  : ListTitle(
                      module: 'bookings',
                      subTitle:
                          'Showing ${filteredIntentions.length} of ${intentions.length} bookings',
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
                    hintText: 'Search service intentions ...',
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
                  itemCount: filteredIntentions.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final intention = filteredIntentions[index];
                    return IntentionsCard(intention: intention);
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

  void onCreatePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingsScreen()),
    );
  }
}
