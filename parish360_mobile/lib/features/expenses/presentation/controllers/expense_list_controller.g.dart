// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExpenseListController)
final expenseListControllerProvider = ExpenseListControllerProvider._();

final class ExpenseListControllerProvider
    extends $AsyncNotifierProvider<ExpenseListController, List<ExpenseInfo>> {
  ExpenseListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseListControllerHash();

  @$internal
  @override
  ExpenseListController create() => ExpenseListController();
}

String _$expenseListControllerHash() =>
    r'691e78c091d21c49bc4457334bcdf13695cadbb5';

abstract class _$ExpenseListController
    extends $AsyncNotifier<List<ExpenseInfo>> {
  FutureOr<List<ExpenseInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ExpenseInfo>>, List<ExpenseInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ExpenseInfo>>, List<ExpenseInfo>>,
              AsyncValue<List<ExpenseInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredExpenses)
final filteredExpensesProvider = FilteredExpensesFamily._();

final class FilteredExpensesProvider
    extends
        $FunctionalProvider<
          List<ExpenseInfo>,
          List<ExpenseInfo>,
          List<ExpenseInfo>
        >
    with $Provider<List<ExpenseInfo>> {
  FilteredExpensesProvider._({
    required FilteredExpensesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredExpensesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredExpensesHash();

  @override
  String toString() {
    return r'filteredExpensesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ExpenseInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ExpenseInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredExpenses(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ExpenseInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ExpenseInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredExpensesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredExpensesHash() => r'6ab8f09d14a768951ce57fc795ca5feb7adee38d';

final class FilteredExpensesFamily extends $Family
    with $FunctionalFamilyOverride<List<ExpenseInfo>, String> {
  FilteredExpensesFamily._()
    : super(
        retry: null,
        name: r'filteredExpensesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredExpensesProvider call(String filter) =>
      FilteredExpensesProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredExpensesProvider';
}
