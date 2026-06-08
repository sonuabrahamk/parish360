// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExpenseInfoController)
final expenseInfoControllerProvider = ExpenseInfoControllerFamily._();

final class ExpenseInfoControllerProvider
    extends $AsyncNotifierProvider<ExpenseInfoController, ExpenseInfo> {
  ExpenseInfoControllerProvider._({
    required ExpenseInfoControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'expenseInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$expenseInfoControllerHash();

  @override
  String toString() {
    return r'expenseInfoControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ExpenseInfoController create() => ExpenseInfoController();

  @override
  bool operator ==(Object other) {
    return other is ExpenseInfoControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$expenseInfoControllerHash() =>
    r'b27df34de3056c5d505233bae6b950b9f29aaedb';

final class ExpenseInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ExpenseInfoController,
          AsyncValue<ExpenseInfo>,
          ExpenseInfo,
          FutureOr<ExpenseInfo>,
          String
        > {
  ExpenseInfoControllerFamily._()
    : super(
        retry: null,
        name: r'expenseInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExpenseInfoControllerProvider call(String expenseId) =>
      ExpenseInfoControllerProvider._(argument: expenseId, from: this);

  @override
  String toString() => r'expenseInfoControllerProvider';
}

abstract class _$ExpenseInfoController extends $AsyncNotifier<ExpenseInfo> {
  late final _$args = ref.$arg as String;
  String get expenseId => _$args;

  FutureOr<ExpenseInfo> build(String expenseId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ExpenseInfo>, ExpenseInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ExpenseInfo>, ExpenseInfo>,
              AsyncValue<ExpenseInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
