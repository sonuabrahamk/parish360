// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ParishReportController)
final parishReportControllerProvider = ParishReportControllerProvider._();

final class ParishReportControllerProvider
    extends $AsyncNotifierProvider<ParishReportController, ParishReportInfo> {
  ParishReportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parishReportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parishReportControllerHash();

  @$internal
  @override
  ParishReportController create() => ParishReportController();
}

String _$parishReportControllerHash() =>
    r'f348dd8fcb4157a80727904aca4b1714ac19b6c0';

abstract class _$ParishReportController
    extends $AsyncNotifier<ParishReportInfo> {
  FutureOr<ParishReportInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ParishReportInfo>, ParishReportInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ParishReportInfo>, ParishReportInfo>,
              AsyncValue<ParishReportInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(StatementInfoController)
final statementInfoControllerProvider = StatementInfoControllerFamily._();

final class StatementInfoControllerProvider
    extends
        $AsyncNotifierProvider<StatementInfoController, List<StatementInfo>> {
  StatementInfoControllerProvider._({
    required StatementInfoControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'statementInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$statementInfoControllerHash();

  @override
  String toString() {
    return r'statementInfoControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  StatementInfoController create() => StatementInfoController();

  @override
  bool operator ==(Object other) {
    return other is StatementInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$statementInfoControllerHash() =>
    r'92cf543ac3fc4136a362e89cd874b084dc0fb533';

final class StatementInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          StatementInfoController,
          AsyncValue<List<StatementInfo>>,
          List<StatementInfo>,
          FutureOr<List<StatementInfo>>,
          (String, String)
        > {
  StatementInfoControllerFamily._()
    : super(
        retry: null,
        name: r'statementInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StatementInfoControllerProvider call(String startDate, String endDate) =>
      StatementInfoControllerProvider._(
        argument: (startDate, endDate),
        from: this,
      );

  @override
  String toString() => r'statementInfoControllerProvider';
}

abstract class _$StatementInfoController
    extends $AsyncNotifier<List<StatementInfo>> {
  late final _$args = ref.$arg as (String, String);
  String get startDate => _$args.$1;
  String get endDate => _$args.$2;

  FutureOr<List<StatementInfo>> build(String startDate, String endDate);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<StatementInfo>>, List<StatementInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<StatementInfo>>, List<StatementInfo>>,
              AsyncValue<List<StatementInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

@ProviderFor(MembersListController)
final membersListControllerProvider = MembersListControllerProvider._();

final class MembersListControllerProvider
    extends $AsyncNotifierProvider<MembersListController, List<MemberInfo>> {
  MembersListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membersListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membersListControllerHash();

  @$internal
  @override
  MembersListController create() => MembersListController();
}

String _$membersListControllerHash() =>
    r'4f3f39a0373bce0d439db4a9a349a9f8df6d8feb';

abstract class _$MembersListController
    extends $AsyncNotifier<List<MemberInfo>> {
  FutureOr<List<MemberInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MemberInfo>>, List<MemberInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MemberInfo>>, List<MemberInfo>>,
              AsyncValue<List<MemberInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredMembersListController)
final filteredMembersListControllerProvider =
    FilteredMembersListControllerFamily._();

final class FilteredMembersListControllerProvider
    extends
        $FunctionalProvider<
          List<MemberInfo>,
          List<MemberInfo>,
          List<MemberInfo>
        >
    with $Provider<List<MemberInfo>> {
  FilteredMembersListControllerProvider._({
    required FilteredMembersListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredMembersListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredMembersListControllerHash();

  @override
  String toString() {
    return r'filteredMembersListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<MemberInfo>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<MemberInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredMembersListController(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MemberInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MemberInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredMembersListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredMembersListControllerHash() =>
    r'17e26bff2ae8e7c9f0bbd15520119f59cb29759f';

final class FilteredMembersListControllerFamily extends $Family
    with $FunctionalFamilyOverride<List<MemberInfo>, String> {
  FilteredMembersListControllerFamily._()
    : super(
        retry: null,
        name: r'filteredMembersListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredMembersListControllerProvider call(String query) =>
      FilteredMembersListControllerProvider._(argument: query, from: this);

  @override
  String toString() => r'filteredMembersListControllerProvider';
}

@ProviderFor(MembersSearchQuery)
final membersSearchQueryProvider = MembersSearchQueryProvider._();

final class MembersSearchQueryProvider
    extends $NotifierProvider<MembersSearchQuery, String> {
  MembersSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membersSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membersSearchQueryHash();

  @$internal
  @override
  MembersSearchQuery create() => MembersSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$membersSearchQueryHash() =>
    r'05cf94c558aaa19388b5573eadeae22497c605d6';

abstract class _$MembersSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredStatementInfoController)
final filteredStatementInfoControllerProvider =
    FilteredStatementInfoControllerFamily._();

final class FilteredStatementInfoControllerProvider
    extends
        $FunctionalProvider<
          List<StatementInfo>,
          List<StatementInfo>,
          List<StatementInfo>
        >
    with $Provider<List<StatementInfo>> {
  FilteredStatementInfoControllerProvider._({
    required FilteredStatementInfoControllerFamily super.from,
    required (String, String, String) super.argument,
  }) : super(
         retry: null,
         name: r'filteredStatementInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredStatementInfoControllerHash();

  @override
  String toString() {
    return r'filteredStatementInfoControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<StatementInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<StatementInfo> create(Ref ref) {
    final argument = this.argument as (String, String, String);
    return filteredStatementInfoController(
      ref,
      argument.$1,
      argument.$2,
      argument.$3,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<StatementInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<StatementInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredStatementInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredStatementInfoControllerHash() =>
    r'b575d0a8da74ec957d970352083e14c0c504e86a';

final class FilteredStatementInfoControllerFamily extends $Family
    with
        $FunctionalFamilyOverride<
          List<StatementInfo>,
          (String, String, String)
        > {
  FilteredStatementInfoControllerFamily._()
    : super(
        retry: null,
        name: r'filteredStatementInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredStatementInfoControllerProvider call(
    String query,
    String startDate,
    String endDate,
  ) => FilteredStatementInfoControllerProvider._(
    argument: (query, startDate, endDate),
    from: this,
  );

  @override
  String toString() => r'filteredStatementInfoControllerProvider';
}

@ProviderFor(StatementSearchQuery)
final statementSearchQueryProvider = StatementSearchQueryProvider._();

final class StatementSearchQueryProvider
    extends $NotifierProvider<StatementSearchQuery, String> {
  StatementSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statementSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statementSearchQueryHash();

  @$internal
  @override
  StatementSearchQuery create() => StatementSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$statementSearchQueryHash() =>
    r'344800f2fce5ceef5c124b637eebc49c22b86294';

abstract class _$StatementSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
