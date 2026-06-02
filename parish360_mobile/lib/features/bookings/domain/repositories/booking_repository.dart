import 'package:parish360_mobile/features/bookings/domain/entities/booking_info.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/booking_request.dart';

abstract class BookingRepository {
  Future<List<BookingInfo>> getAllBookings(String type);
  Future<BookingInfo> getBookingInfo(String bookingId);
  Future<List<BookingInfo>> createBooking(BookingRequest bookingRequest);
  Future<BookingInfo> updateBooking(String bookingId, BookingInfo bookingInfo);
  Future<BookingRequest> getBookingByCode(String bookingCode);
  Future<void> deleteBooking(String bookingId);
  Future<BookingInfo> cancelBooking(String bookingId);
}
