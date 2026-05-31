import 'package:parish360_mobile/features/configurations/domain/entities/parish_info.dart';

abstract class ParishRepository {
  Future<ParishInfo> getParishInfo();
  Future<ParishInfo> updateParishInfo(ParishInfo parishInfo);
}
