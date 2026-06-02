import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/booking_info.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/booking_request.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'bookings_api.g.dart';

@RestApi()
abstract class BookingsApi {
  factory BookingsApi(Dio dio, {String baseUrl}) = _BookingsApi;

  @GET('/bookings')
  Future<List<BookingInfo>> getAllBookings(@Query('type') String type);

  @POST('/bookings')
  Future<List<BookingInfo>> createBooking(
    @Body() BookingRequest bookingRequest,
  );

  @GET('/bookings/{bookingId}')
  Future<BookingInfo> getBookingInfo(@Path('bookingId') String bookingId);

  @PATCH('/bookings/{bookingId}')
  Future<BookingInfo> updateBooking(
    @Path('bookingId') String bookingId,
    @Body() BookingInfo bookingInfo,
  );

  @GET('/bookings/view/{bookingCode}')
  Future<BookingRequest> getBookingByCode(
    @Path('bookingCode') String bookingCode,
  );

  @DELETE('/bookings/{bookingId}')
  Future<void> deleteBooking(@Path('bookingId') String bookingId);

  @PATCH('/bookings/{bookingId}')
  Future<BookingInfo> cancelBooking(@Path('bookingId') String bookingId);
}
