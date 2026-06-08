import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/associations/domain/entities/associates_request.dart';
import 'package:parish360_mobile/features/associations/domain/entities/committee_member_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'py_associations_api.g.dart';

@RestApi()
abstract class PyAssociationsApi {
  factory PyAssociationsApi(Dio dio, {String baseUrl}) = _PyAssociationsApi;

  @GET('/associations/{pyAssociationId}/committee')
  Future<List<CommitteeMemberInfo>> getCommitteeMembers(
    @Path('pyAssociationId') String pyAssociationId,
  );

  @GET('/associations/{pyAssociationId}/committee/{committeeMemberId}')
  Future<CommitteeMemberInfo> getCommitteeMember(
    @Path('pyAssociationId') String pyAssociationId,
    @Path('committeeMemberId') String committeeMemberId,
  );

  @POST('/associations/{pyAssociationId}/committee')
  Future<CommitteeMemberInfo> addCommitteeMember(
    @Path('pyAssociationId') String pyAssociationId,
    @Body() CommitteeMemberInfo committeeMemberInfo,
  );

  @PATCH('/associations/{pyAssociationId}/committee/{committeeMemberId}')
  Future<CommitteeMemberInfo> updateCommitteeMember(
    @Path('pyAssociationId') String pyAssociationId,
    @Path('committeeMemberId') String committeeMemberId,
    @Body() CommitteeMemberInfo committeeMemberInfo,
  );

  @DELETE('/associations/{pyAssociationId}/committee/{committeeMemberId}')
  Future<void> deleteCommitteeMember(
    @Path('pyAssociationId') String pyAssociationId,
    @Path('committeeMemberId') String committeeMemberId,
  );

  @POST('/associations/{pyAssociationId}/associates')
  Future<dynamic> mapAssociates(
    @Path('pyAssociationId') String pyAssociationId,
    @Body() AssociatesRequest associatesRequest,
  );

  @DELETE('/associations/{pyAssociationId}/associates')
  Future<dynamic> unMapAssociates(
    @Path('pyAssociationId') String pyAssociationId,
    @Body() AssociatesRequest associatesRequest,
  );

  @GET('/associations/{pyAssociationId}/associates')
  Future<dynamic> getAssociates(
    @Path('pyAssociationId') String pyAssociationId,
  );
}
