import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/families/domain/entities/migration_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'migration_api.g.dart';

@RestApi()
abstract class MigrationApi {

  factory MigrationApi(Dio dio, {String baseUrl}) = _MigrationApi;

  @POST('/family-records/{familyId}/members/{memberId}/migrations')
  Future<MigrationInfo> createMigration(@Path('familyId') String familyId, @Path('memberId') String memberId, @Body() MigrationInfo migrationInfo);

  @PATCH('/family-records/{familyId}/members/{memberId}/migrations/{migrationId}')
  Future<MigrationInfo> updateMigration(@Path('familyId') String familyId, @Path('memberId') String memberId, @Path('migrationId') String migrationId, @Body() MigrationInfo migrationInfo);

  @GET('/family-records/{familyId}/members/{memberId}/migrations/{migrationId}')
  Future<MigrationInfo> getMigrationById(@Path('familyId') String familyId, @Path('memberId') String memberId, @Path('migrationId') String migrationId);

  @GET('/family-records/{familyId}/members/{memberId}/migrations')
  Future<List<MigrationInfo>> getMigrations(@Path('familyId') String familyId, @Path('memberId') String memberId);

  @DELETE('/family-records/{familyId}/members/{memberId}/migrations/{migrationId}')
  Future<void> deleteMigration(@Path('familyId') String familyId, @Path('memberId') String memberId, @Path('migrationId') String migrationId);
  
}
