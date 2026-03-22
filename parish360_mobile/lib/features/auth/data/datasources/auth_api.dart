import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/auth/domain/entities/login_request.dart';
import 'package:parish360_mobile/features/auth/domain/entities/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio authDio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);
}
