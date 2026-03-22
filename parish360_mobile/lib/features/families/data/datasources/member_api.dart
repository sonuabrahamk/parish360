import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';
import 'package:retrofit/retrofit.dart';

part 'member_api.g.dart';

@RestApi()
abstract class MemberApi {
  factory MemberApi(Dio dio, {String baseUrl}) = _MemberApi;

  @POST('/family-records/{familyId}/members')
  Future<MemberInfo> createMember(@Path('familyId') String familyId, @Body() MemberInfo memberInfo);

  @PATCH('/family-records/{familyId}/members/{memberId}')
  Future<MemberInfo> updateMember(@Path('familyId') String familyId, @Path('memberId') String memberId, @Body() MemberInfo memberInfo);

  @GET('/family-records/{familyId}/members/{memberId}')
  Future<MemberInfo> getMemberById(@Path('familyId') String familyId, @Path('memberId') String memberId);

  @GET('/family-records/{familyId}/members')
  Future<List<MemberInfo>> getMembers(@Path('familyId') String familyId);

  @DELETE('/family-records/{familyId}/members/{memberId}')
  Future<void> deleteMember(@Path('familyId') String familyId, @Path('memberId') String memberId);
}
