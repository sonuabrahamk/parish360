import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/payments/data/datasources/payments_api.dart';
import 'package:parish360_mobile/features/payments/data/repositories/payments_repository_impl.dart';
import 'package:parish360_mobile/features/payments/domain/repositories/payments_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_providers.g.dart';

@riverpod
PaymentsApi paymentsApi(Ref ref) {
  return PaymentsApi(ref.watch(dioProvider));
}

@riverpod
PaymentsRepository paymentsRepository(Ref ref) {
  return PaymentsRepositoryImpl(ref.watch(paymentsApiProvider));
}
