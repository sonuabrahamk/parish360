import 'package:parish360_mobile/features/bookings/data/providers/bookings_providers.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/booking_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_list_controller.g.dart';

@riverpod
class BookingListController extends _$BookingListController {
  @override
  Future<List<BookingInfo>> build(String type) async {
    return await ref.read(bookingRepositoryProvider).getAllBookings(type);
  }
}

@riverpod
List<BookingInfo> filteredBookingInfoList(Ref ref, String filter, String type) {
  final bookingsListAsync = ref.watch(bookingListControllerProvider(type));

  return bookingsListAsync.when(
    data: (bookings) {
      final lowerFilter = filter.toLowerCase();

      return bookings.where((booking) {
        final code = booking.bookingCode?.toLowerCase() ?? '';
        final bookedBy = booking.bookedBy?.toLowerCase() ?? '';
        final familyCode = booking.familyCode?.toLowerCase() ?? '';
        final event = booking.event?.toLowerCase() ?? '';
        final description = booking.description?.toLowerCase() ?? '';
        final type = booking.bookingType?.toLowerCase() ?? '';
        final status = booking.status?.toLowerCase() ?? '';
        final date = booking.bookedFrom?.toString().toLowerCase() ?? '';
        final resource = booking.resource?.name?.toLowerCase() ?? '';

        return code.contains(lowerFilter) ||
            bookedBy.contains(lowerFilter) ||
            familyCode.contains(lowerFilter) ||
            event.contains(lowerFilter) ||
            description.contains(lowerFilter) ||
            type.contains(lowerFilter) ||
            status.contains(lowerFilter) ||
            resource.contains(lowerFilter) ||
            date.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
class BookingSearchQuery extends _$BookingSearchQuery {
  @override
  String build() => '';

  void update(String value) => state = value;
}
