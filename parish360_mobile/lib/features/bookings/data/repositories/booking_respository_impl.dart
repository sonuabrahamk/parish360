import 'package:parish360_mobile/features/bookings/data/datasources/bookings_api.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/booking_info.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/booking_request.dart';
import 'package:parish360_mobile/features/bookings/domain/repositories/booking_repository.dart';

class BookingRespositoryImpl implements BookingRepository {
  final BookingsApi _bookingsApi;

  BookingRespositoryImpl(this._bookingsApi);

  @override
  Future<BookingInfo> cancelBooking(String bookingId) async {
    return await _bookingsApi.cancelBooking(bookingId);
  }

  @override
  Future<List<BookingInfo>> createBooking(BookingRequest bookingRequest) async {
    return await _bookingsApi.createBooking(bookingRequest);
  }

  @override
  Future<void> deleteBooking(String bookingId) async {
    return await _bookingsApi.deleteBooking(bookingId);
  }

  @override
  Future<List<BookingInfo>> getAllBookings(String type) async {
    return await _bookingsApi.getAllBookings(type);
  }

  @override
  Future<BookingRequest> getBookingByCode(String bookingCode) async {
    return await _bookingsApi.getBookingByCode(bookingCode);
  }

  @override
  Future<BookingInfo> getBookingInfo(String bookingId) async {
    return await _bookingsApi.getBookingInfo(bookingId);
  }

  @override
  Future<BookingInfo> updateBooking(
    String bookingId,
    BookingInfo bookingInfo,
  ) async {
    return await _bookingsApi.updateBooking(bookingId, bookingInfo);
  }
}
