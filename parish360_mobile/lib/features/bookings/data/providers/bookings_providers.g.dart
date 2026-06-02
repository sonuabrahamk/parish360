// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookingsApi)
final bookingsApiProvider = BookingsApiProvider._();

final class BookingsApiProvider
    extends $FunctionalProvider<BookingsApi, BookingsApi, BookingsApi>
    with $Provider<BookingsApi> {
  BookingsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingsApiHash();

  @$internal
  @override
  $ProviderElement<BookingsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BookingsApi create(Ref ref) {
    return bookingsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingsApi>(value),
    );
  }
}

String _$bookingsApiHash() => r'e386faa14c26f4b840c1838cc02d5def548abfbd';

@ProviderFor(bookingRepository)
final bookingRepositoryProvider = BookingRepositoryProvider._();

final class BookingRepositoryProvider
    extends
        $FunctionalProvider<
          BookingRepository,
          BookingRepository,
          BookingRepository
        >
    with $Provider<BookingRepository> {
  BookingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookingRepository create(Ref ref) {
    return bookingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingRepository>(value),
    );
  }
}

String _$bookingRepositoryHash() => r'fbc802ea7fcf106a3c155281a28eac29621c2dae';
