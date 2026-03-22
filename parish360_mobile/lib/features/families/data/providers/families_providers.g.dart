// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'families_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(familiesApi)
final familiesApiProvider = FamiliesApiProvider._();

final class FamiliesApiProvider
    extends $FunctionalProvider<FamiliesApi, FamiliesApi, FamiliesApi>
    with $Provider<FamiliesApi> {
  FamiliesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familiesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familiesApiHash();

  @$internal
  @override
  $ProviderElement<FamiliesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FamiliesApi create(Ref ref) {
    return familiesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FamiliesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FamiliesApi>(value),
    );
  }
}

String _$familiesApiHash() => r'998c8f47da86f453172b049570a09a450dd763b6';

@ProviderFor(familyInfoRepository)
final familyInfoRepositoryProvider = FamilyInfoRepositoryProvider._();

final class FamilyInfoRepositoryProvider
    extends
        $FunctionalProvider<
          FamilyInfoRepository,
          FamilyInfoRepository,
          FamilyInfoRepository
        >
    with $Provider<FamilyInfoRepository> {
  FamilyInfoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyInfoRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyInfoRepositoryHash();

  @$internal
  @override
  $ProviderElement<FamilyInfoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FamilyInfoRepository create(Ref ref) {
    return familyInfoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FamilyInfoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FamilyInfoRepository>(value),
    );
  }
}

String _$familyInfoRepositoryHash() =>
    r'80c142115b6d56ea6ea92aa694f311aeb88a9486';

@ProviderFor(FamilySearchQuery)
final familySearchQueryProvider = FamilySearchQueryProvider._();

final class FamilySearchQueryProvider
    extends $NotifierProvider<FamilySearchQuery, String> {
  FamilySearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familySearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familySearchQueryHash();

  @$internal
  @override
  FamilySearchQuery create() => FamilySearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$familySearchQueryHash() => r'4ac2972ccef710bc318be16d5b0133aa28cb0496';

abstract class _$FamilySearchQuery extends $Notifier<String> {
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

@ProviderFor(filteredFamilyInfoList)
final filteredFamilyInfoListProvider = FilteredFamilyInfoListFamily._();

final class FilteredFamilyInfoListProvider
    extends
        $FunctionalProvider<
          List<FamilyInfo>,
          List<FamilyInfo>,
          List<FamilyInfo>
        >
    with $Provider<List<FamilyInfo>> {
  FilteredFamilyInfoListProvider._({
    required FilteredFamilyInfoListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredFamilyInfoListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredFamilyInfoListHash();

  @override
  String toString() {
    return r'filteredFamilyInfoListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<FamilyInfo>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<FamilyInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredFamilyInfoList(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FamilyInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FamilyInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredFamilyInfoListProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredFamilyInfoListHash() =>
    r'8ae650ac564fdd09c3ed771c4cad061d753f9a8b';

final class FilteredFamilyInfoListFamily extends $Family
    with $FunctionalFamilyOverride<List<FamilyInfo>, String> {
  FilteredFamilyInfoListFamily._()
    : super(
        retry: null,
        name: r'filteredFamilyInfoListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredFamilyInfoListProvider call(String filter) =>
      FilteredFamilyInfoListProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredFamilyInfoListProvider';
}
