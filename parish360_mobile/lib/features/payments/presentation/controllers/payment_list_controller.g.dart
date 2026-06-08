// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PaymentListController)
final paymentListControllerProvider = PaymentListControllerProvider._();

final class PaymentListControllerProvider
    extends $AsyncNotifierProvider<PaymentListController, List<PaymentInfo>> {
  PaymentListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentListControllerHash();

  @$internal
  @override
  PaymentListController create() => PaymentListController();
}

String _$paymentListControllerHash() =>
    r'2cc34516df01d3c9685e41881014ea6169da5d3c';

abstract class _$PaymentListController
    extends $AsyncNotifier<List<PaymentInfo>> {
  FutureOr<List<PaymentInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PaymentInfo>>, List<PaymentInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PaymentInfo>>, List<PaymentInfo>>,
              AsyncValue<List<PaymentInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredPayments)
final filteredPaymentsProvider = FilteredPaymentsFamily._();

final class FilteredPaymentsProvider
    extends
        $FunctionalProvider<
          List<PaymentInfo>,
          List<PaymentInfo>,
          List<PaymentInfo>
        >
    with $Provider<List<PaymentInfo>> {
  FilteredPaymentsProvider._({
    required FilteredPaymentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredPaymentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredPaymentsHash();

  @override
  String toString() {
    return r'filteredPaymentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<PaymentInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PaymentInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredPayments(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PaymentInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PaymentInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredPaymentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredPaymentsHash() => r'f0e68e15d93029c471449135833280cac7c0333b';

final class FilteredPaymentsFamily extends $Family
    with $FunctionalFamilyOverride<List<PaymentInfo>, String> {
  FilteredPaymentsFamily._()
    : super(
        retry: null,
        name: r'filteredPaymentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredPaymentsProvider call(String filter) =>
      FilteredPaymentsProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredPaymentsProvider';
}
