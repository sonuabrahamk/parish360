// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BookingListController)
final bookingListControllerProvider = BookingListControllerFamily._();

final class BookingListControllerProvider
    extends $AsyncNotifierProvider<BookingListController, List<BookingInfo>> {
  BookingListControllerProvider._({
    required BookingListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookingListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingListControllerHash();

  @override
  String toString() {
    return r'bookingListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BookingListController create() => BookingListController();

  @override
  bool operator ==(Object other) {
    return other is BookingListControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingListControllerHash() =>
    r'fd944ae494acd105cf711e3c6ad3295a4fa91973';

final class BookingListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BookingListController,
          AsyncValue<List<BookingInfo>>,
          List<BookingInfo>,
          FutureOr<List<BookingInfo>>,
          String
        > {
  BookingListControllerFamily._()
    : super(
        retry: null,
        name: r'bookingListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookingListControllerProvider call(String type) =>
      BookingListControllerProvider._(argument: type, from: this);

  @override
  String toString() => r'bookingListControllerProvider';
}

abstract class _$BookingListController
    extends $AsyncNotifier<List<BookingInfo>> {
  late final _$args = ref.$arg as String;
  String get type => _$args;

  FutureOr<List<BookingInfo>> build(String type);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BookingInfo>>, List<BookingInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BookingInfo>>, List<BookingInfo>>,
              AsyncValue<List<BookingInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(filteredBookingInfoList)
final filteredBookingInfoListProvider = FilteredBookingInfoListFamily._();

final class FilteredBookingInfoListProvider
    extends
        $FunctionalProvider<
          List<BookingInfo>,
          List<BookingInfo>,
          List<BookingInfo>
        >
    with $Provider<List<BookingInfo>> {
  FilteredBookingInfoListProvider._({
    required FilteredBookingInfoListFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'filteredBookingInfoListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredBookingInfoListHash();

  @override
  String toString() {
    return r'filteredBookingInfoListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<BookingInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<BookingInfo> create(Ref ref) {
    final argument = this.argument as (String, String);
    return filteredBookingInfoList(ref, argument.$1, argument.$2);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<BookingInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<BookingInfo>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredBookingInfoListProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredBookingInfoListHash() =>
    r'f9d0a46c662a9d6bbc8aee4877b20e715b8221ce';

final class FilteredBookingInfoListFamily extends $Family
    with $FunctionalFamilyOverride<List<BookingInfo>, (String, String)> {
  FilteredBookingInfoListFamily._()
    : super(
        retry: null,
        name: r'filteredBookingInfoListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredBookingInfoListProvider call(String filter, String type) =>
      FilteredBookingInfoListProvider._(argument: (filter, type), from: this);

  @override
  String toString() => r'filteredBookingInfoListProvider';
}

@ProviderFor(BookingSearchQuery)
final bookingSearchQueryProvider = BookingSearchQueryProvider._();

final class BookingSearchQueryProvider
    extends $NotifierProvider<BookingSearchQuery, String> {
  BookingSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingSearchQueryHash();

  @$internal
  @override
  BookingSearchQuery create() => BookingSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$bookingSearchQueryHash() =>
    r'a9b5749c09d212770fd5c0f44b61cfe7b6d9d8fd';

abstract class _$BookingSearchQuery extends $Notifier<String> {
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
