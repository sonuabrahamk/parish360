import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/payments/domain/entities/payment_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'payments_api.g.dart';

@RestApi()
abstract class PaymentsApi {
  factory PaymentsApi(Dio dio, {String baseUrl}) = _PaymentsApi;

  @GET('/payments')
  Future<List<PaymentInfo>> getPayments();

  @GET('/payments/{paymentId}')
  Future<PaymentInfo> getPaymentInfo(@Path('paymentId') String paymentId);

  @DioResponseType(ResponseType.bytes)
  @POST('/payments')
  Future<Uint8List> createPayment(@Body() PaymentInfo paymentInfo);

  @PATCH('/payments/{paymentId}')
  Future<PaymentInfo> updatePayment(
    @Path('paymentId') String paymentId,
    @Body() PaymentInfo paymentInfo,
  );

  @DELETE('/payments/{paymentId}')
  Future<void> deletePayment(@Path('paymentId') String paymentId);

  @GET('/payments/{paymentId}')
  Future<Uint8List> getPaymentReceipt(@Path('paymentId') String paymentId);
}
