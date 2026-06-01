import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'associations_api.g.dart';

@RestApi()
abstract class AssociationsApi {
  factory AssociationsApi(Dio dio, {String baseUrl}) = _AssociationsApi;

  @GET('/configurations/association')
  Future<List<AssociationInfo>> getAllAssociations();

  @POST('/configurations/association')
  Future<AssociationInfo> createAssociation(
    @Body() AssociationInfo associationInfo,
  );

  @GET('/configurations/association/{associationId}')
  Future<AssociationInfo> getAssociationInfo(
    @Path('associationId') String associationId,
  );

  @PATCH('/configurations/association/{associationId}')
  Future<AssociationInfo> updateAssociation(
    @Path('associationId') String associationId,
    @Body() AssociationInfo associationInfo,
  );

  @DELETE('/configurations/association/{associationId}')
  Future<void> deleteAssociation(@Path('associationId') String associationId);
}
