import 'package:parish360_mobile/features/users/data/datasources/users_api.dart';
import 'package:parish360_mobile/features/users/domain/entities/user_info.dart';
import 'package:parish360_mobile/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersApi _usersApi;

  UsersRepositoryImpl(this._usersApi);

  @override
  Future<UserInfo> createUser(UserInfo userInfo) async {
    return await _usersApi.createUser(userInfo);
  }

  @override
  Future<void> deleteUser(String userId) async {
    return await _usersApi.deleteUser(userId);
  }

  @override
  Future<UserInfo> getUserInfo(String userId) async {
    return await _usersApi.getUserInfo(userId);
  }

  @override
  Future<List<UserInfo>> getUsers() async {
    return await _usersApi.getUsers();
  }

  @override
  Future<UserInfo> updateUser(String userId, UserInfo userInfo) async {
    return await _usersApi.updateUser(userId, userInfo);
  }
}
