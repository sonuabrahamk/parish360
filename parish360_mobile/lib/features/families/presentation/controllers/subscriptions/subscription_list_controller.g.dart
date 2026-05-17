// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubscriptionListController)
final subscriptionListControllerProvider = SubscriptionListControllerFamily._();

final class SubscriptionListControllerProvider
    extends
        $AsyncNotifierProvider<
          SubscriptionListController,
          List<SubscriptionInfo>
        > {
  SubscriptionListControllerProvider._({
    required SubscriptionListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'subscriptionListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$subscriptionListControllerHash();

  @override
  String toString() {
    return r'subscriptionListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SubscriptionListController create() => SubscriptionListController();

  @override
  bool operator ==(Object other) {
    return other is SubscriptionListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$subscriptionListControllerHash() =>
    r'2a44a665465b3e474763237e592996750a135754';

final class SubscriptionListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SubscriptionListController,
          AsyncValue<List<SubscriptionInfo>>,
          List<SubscriptionInfo>,
          FutureOr<List<SubscriptionInfo>>,
          String
        > {
  SubscriptionListControllerFamily._()
    : super(
        retry: null,
        name: r'subscriptionListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SubscriptionListControllerProvider call(String familyId) =>
      SubscriptionListControllerProvider._(argument: familyId, from: this);

  @override
  String toString() => r'subscriptionListControllerProvider';
}

abstract class _$SubscriptionListController
    extends $AsyncNotifier<List<SubscriptionInfo>> {
  late final _$args = ref.$arg as String;
  String get familyId => _$args;

  FutureOr<List<SubscriptionInfo>> build(String familyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<SubscriptionInfo>>, List<SubscriptionInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SubscriptionInfo>>,
                List<SubscriptionInfo>
              >,
              AsyncValue<List<SubscriptionInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
