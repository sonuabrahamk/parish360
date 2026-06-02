import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/bookings/data/datasources/bookings_api.dart';
import 'package:parish360_mobile/features/bookings/data/repositories/booking_respository_impl.dart';
import 'package:parish360_mobile/features/bookings/domain/repositories/booking_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_providers.g.dart';

@riverpod
BookingsApi bookingsApi(Ref ref) {
  return BookingsApi(ref.watch(dioProvider));
}

@riverpod
BookingRepository bookingRepository(Ref ref) {
  return BookingRespositoryImpl(ref.watch(bookingsApiProvider));
}
