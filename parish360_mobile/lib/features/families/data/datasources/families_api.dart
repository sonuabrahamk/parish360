import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:retrofit/retrofit.dart';

part 'families_api.g.dart';

@RestApi()
abstract class FamiliesApi {
  factory FamiliesApi(Dio dio, {String baseUrl}) = _FamiliesApi;

  @POST('/family-records')
  Future<FamilyInfo> createFamily(@Body() FamilyInfo familyInfo);

  @PATCH('/family-records/{familyId}')
  Future<FamilyInfo> updateFamily(@Path('familyId') String familyId, @Body() FamilyInfo familyInfo);

  @GET('/family-records/{familyId}')
  Future<FamilyInfo> getFamilyById(@Path('familyId') String familyId);

  @GET('/family-records')
  Future<List<FamilyInfo>> getAllFamilies();
}
