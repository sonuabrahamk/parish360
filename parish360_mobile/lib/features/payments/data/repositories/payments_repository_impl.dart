import 'dart:typed_data';

import 'package:parish360_mobile/features/payments/data/datasources/payments_api.dart';
import 'package:parish360_mobile/features/payments/domain/entities/payment_info.dart';
import 'package:parish360_mobile/features/payments/domain/repositories/payments_repository.dart';

class PaymentsRepositoryImpl implements PaymentsRepository {
  final PaymentsApi _paymentsApi;

  PaymentsRepositoryImpl(this._paymentsApi);

  @override
  Future<Uint8List> createPayment(PaymentInfo paymentInfo) async {
    return await _paymentsApi.createPayment(paymentInfo);
  }

  @override
  Future<void> deletePayment(String paymentId) async {
    return await _paymentsApi.deletePayment(paymentId);
  }

  @override
  Future<PaymentInfo> getPaymentInfo(String paymentId) async {
    return await _paymentsApi.getPaymentInfo(paymentId);
  }

  @override
  Future<Uint8List> getPaymentReceipt(String paymentId) async {
    return await _paymentsApi.getPaymentReceipt(paymentId);
  }

  @override
  Future<List<PaymentInfo>> getPayments() async {
    return await _paymentsApi.getPayments();
  }

  @override
  Future<PaymentInfo> updatePayment(
    String paymentId,
    PaymentInfo paymentInfo,
  ) async {
    return await _paymentsApi.updatePayment(paymentId, paymentInfo);
  }
}
