import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api.dart';
import '../../domain/entities/login_request.dart';
import '../../domain/entities/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;

  AuthRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final dto = await api.login(request);
    return dto;
  }

}
