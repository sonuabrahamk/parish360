import 'package:parish360_mobile/features/users/data/providers/user_providers.dart';
import 'package:parish360_mobile/features/users/domain/entities/user_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list_controller.g.dart';

@riverpod
class UserListController extends _$UserListController {
  @override
  Future<List<UserInfo>> build() async {
    return await ref.read(usersRepositoryProvider).getUsers();
  }
}

@riverpod
List<UserInfo> filteredUsers(Ref ref, String filter) {
  final userListAsync = ref.watch(userListControllerProvider);

  return userListAsync.when(
    data: (users) {
      final lowerFilter = filter.toLowerCase();

      return users.where((user) {
        final firstName = user.firstName?.toLowerCase() ?? '';
        final lastName = user.lastName?.toLowerCase() ?? '';
        final username = user.username?.toLowerCase() ?? '';
        final email = user.email?.toLowerCase() ?? '';
        final contact = user.contact?.toLowerCase() ?? '';
        final active = user.isActive?.toString().toLowerCase() ?? '';
        final resetPassword =
            user.isResetPassword?.toString().toLowerCase() ?? '';

        return firstName.contains(lowerFilter) ||
            lastName.contains(lowerFilter) ||
            username.contains(lowerFilter) ||
            email.contains(lowerFilter) ||
            contact.contains(lowerFilter) ||
            active.contains(lowerFilter) ||
            resetPassword.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
