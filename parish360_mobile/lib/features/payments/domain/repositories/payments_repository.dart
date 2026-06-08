import 'dart:typed_data';

import 'package:parish360_mobile/features/payments/domain/entities/payment_info.dart';

abstract class PaymentsRepository {
  Future<List<PaymentInfo>> getPayments();
  Future<PaymentInfo> getPaymentInfo(String paymentId);
  Future<Uint8List> createPayment(PaymentInfo paymentInfo);
  Future<PaymentInfo> updatePayment(String paymentId, PaymentInfo paymentInfo);
  Future<void> deletePayment(String paymentId);
  Future<Uint8List> getPaymentReceipt(String paymentId);
}
