import 'package:parish360_mobile/features/users/domain/entities/user_info.dart';

abstract class UsersRepository {
  Future<List<UserInfo>> getUsers();
  Future<UserInfo> getUserInfo(String userId);
  Future<UserInfo> createUser(UserInfo userInfo);
  Future<UserInfo> updateUser(String userId, UserInfo userInfo);
  Future<void> deleteUser(String userId);
}
