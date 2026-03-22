// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(memberApi)
final memberApiProvider = MemberApiProvider._();

final class MemberApiProvider
    extends $FunctionalProvider<MemberApi, MemberApi, MemberApi>
    with $Provider<MemberApi> {
  MemberApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memberApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memberApiHash();

  @$internal
  @override
  $ProviderElement<MemberApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MemberApi create(Ref ref) {
    return memberApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MemberApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MemberApi>(value),
    );
  }
}

String _$memberApiHash() => r'5444bbcfd6ca970752f7e7f50ffe182b48d2e156';

@ProviderFor(memberRepository)
final memberRepositoryProvider = MemberRepositoryProvider._();

final class MemberRepositoryProvider
    extends
        $FunctionalProvider<
          MemberRepository,
          MemberRepository,
          MemberRepository
        >
    with $Provider<MemberRepository> {
  MemberRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memberRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memberRepositoryHash();

  @$internal
  @override
  $ProviderElement<MemberRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MemberRepository create(Ref ref) {
    return memberRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MemberRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MemberRepository>(value),
    );
  }
}

String _$memberRepositoryHash() => r'd2acb747219aa9cd61cad65a78ec023c8849d929';
