import 'package:parish360_mobile/features/auth/domain/entities/permissions.dart';
import 'package:parish360_mobile/features/auth/domain/entities/user.dart';

class LoginResponse {
  final String accessToken;
  final Permissions permissions;
  final User userInfo;

  LoginResponse({
    required this.accessToken,
    required this.permissions,
    required this.userInfo,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] as String,
      permissions: Permissions.fromJson(json['permissions'] as Map<String, dynamic>),
      userInfo: User.fromJson(json['user_info'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'permissions': permissions.toJson(),
      'user_info': userInfo.toJson(),
    };
  }
}