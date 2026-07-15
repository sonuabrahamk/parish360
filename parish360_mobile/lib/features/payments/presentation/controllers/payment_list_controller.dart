import 'package:parish360_mobile/features/payments/data/providers/payment_providers.dart';
import 'package:parish360_mobile/features/payments/domain/entities/payment_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_list_controller.g.dart';

@riverpod
class PaymentListController extends _$PaymentListController {
  @override
  Future<List<PaymentInfo>> build() async {
    return await ref.read(paymentsRepositoryProvider).getPayments();
  }
}

@riverpod
List<PaymentInfo> filteredPayments(Ref ref, String filter) {
  final paymentListAsync = ref.watch(paymentListControllerProvider);

  return paymentListAsync.when(
    data: (payments) {
      final lowerFilter = filter.toLowerCase();

      return payments.where((payment) {
        final type = payment.type?.toLowerCase() ?? '';
        final payee = payment.payee?.toLowerCase() ?? '';
        final paidTo = payment.paidTo?.toLowerCase() ?? '';
        final description = payment.description?.toLowerCase() ?? '';
        final amount = payment.amount?.toString().toLowerCase() ?? '';
        final bookingCode = payment.bookingCode?.toLowerCase() ?? '';
        final familyCode = payment.familyCode?.toLowerCase() ?? '';
        final subscriptionDate =
            payment.subscriptionFrom?.toString().toLowerCase() ?? '';
        final date = payment.createdAt?.toString().toLowerCase() ?? '';

        return type.contains(lowerFilter) ||
            payee.contains(lowerFilter) ||
            paidTo.contains(lowerFilter) ||
            description.contains(lowerFilter) ||
            amount.contains(lowerFilter) ||
            bookingCode.contains(lowerFilter) ||
            familyCode.contains(lowerFilter) ||
            subscriptionDate.contains(lowerFilter) ||
            date.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
