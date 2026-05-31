import 'package:parish360_mobile/features/configurations/data/datasources/parish_api.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/parish_info.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/parish_repository.dart';

class ParishRepositoryImpl implements ParishRepository {
  final ParishApi _parishApi;

  ParishRepositoryImpl(this._parishApi);

  @override
  Future<ParishInfo> getParishInfo() async {
    return await _parishApi.getParishInfo();
  }

  @override
  Future<ParishInfo> updateParishInfo(
    ParishInfo parishInfo,
  ) async {
    return await _parishApi.updateParishInfo(parishInfo);
  }
}
