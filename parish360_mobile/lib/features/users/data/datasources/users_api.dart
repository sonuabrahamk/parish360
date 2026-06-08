import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/users/domain/entities/user_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'users_api.g.dart';

@RestApi()
abstract class UsersApi {
  factory UsersApi(Dio dio, {String baseUrl}) = _UsersApi;

  @GET('/users')
  Future<List<UserInfo>> getUsers();

  @GET('/users/{userId}')
  Future<UserInfo> getUserInfo(@Path('userId') String userId);

  @POST('/users')
  Future<UserInfo> createUser(@Body() UserInfo userInfo);

  @PATCH('/users/{userId}')
  Future<UserInfo> updateUser(
    @Path('userId') String userId,
    @Body() UserInfo userInfo,
  );

  @DELETE('/users/{userId}')
  Future<void> deleteUser(@Path('userId') String userId);
}
