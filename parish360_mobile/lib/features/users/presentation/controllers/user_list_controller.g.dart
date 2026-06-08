// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserListController)
final userListControllerProvider = UserListControllerProvider._();

final class UserListControllerProvider
    extends $AsyncNotifierProvider<UserListController, List<UserInfo>> {
  UserListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userListControllerHash();

  @$internal
  @override
  UserListController create() => UserListController();
}

String _$userListControllerHash() =>
    r'705339d2b70bad4049870b142b63eab3a6aec25f';

abstract class _$UserListController extends $AsyncNotifier<List<UserInfo>> {
  FutureOr<List<UserInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<UserInfo>>, List<UserInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<UserInfo>>, List<UserInfo>>,
              AsyncValue<List<UserInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredUsers)
final filteredUsersProvider = FilteredUsersFamily._();

final class FilteredUsersProvider
    extends $FunctionalProvider<List<UserInfo>, List<UserInfo>, List<UserInfo>>
    with $Provider<List<UserInfo>> {
  FilteredUsersProvider._({
    required FilteredUsersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredUsersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredUsersHash();

  @override
  String toString() {
    return r'filteredUsersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<UserInfo>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<UserInfo> create(Ref ref) {
    final argument = this.argument as String;
    return filteredUsers(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredUsersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredUsersHash() => r'69221394dae9915ffb9ffdb7687917dc45a51b6d';

final class FilteredUsersFamily extends $Family
    with $FunctionalFamilyOverride<List<UserInfo>, String> {
  FilteredUsersFamily._()
    : super(
        retry: null,
        name: r'filteredUsersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredUsersProvider call(String filter) =>
      FilteredUsersProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredUsersProvider';
}
