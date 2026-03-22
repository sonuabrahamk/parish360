import '../entities/login_request.dart';
import '../entities/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest request);
}
