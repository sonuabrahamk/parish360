import 'package:parish360_mobile/features/ceremonies/data/providers/ceremony_providers.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ceremony_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ceremony_info_controller.g.dart';

@riverpod
class CeremonyInfoController extends _$CeremonyInfoController {
  @override
  Future<CeremonyInfo> build(String ceremonyId) async {
    return await ref
        .read(ceremoniesRepositoryProvider)
        .getCeremonyInfo(ceremonyId);
  }

  Future<CeremonyInfo> createCeremony(CeremonyInfo ceremonyInfo) async {
    return await ref
        .read(ceremoniesRepositoryProvider)
        .createCeremony(ceremonyInfo);
  }

  Future<CeremonyInfo> updateCeremony(
    String ceremonyId,
    CeremonyInfo ceremonyInfo,
  ) async {
    return await ref
        .read(ceremoniesRepositoryProvider)
        .updateCeremony(ceremonyId, ceremonyInfo);
  }

  Future<void> deleteCeremony(String ceremonyId) async {
    return await ref
        .read(ceremoniesRepositoryProvider)
        .deleteCeremony(ceremonyId);
  }
}
