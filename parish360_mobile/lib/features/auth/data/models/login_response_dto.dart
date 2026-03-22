import 'package:json_annotation/json_annotation.dart';
import 'package:parish360_mobile/features/auth/data/models/permissions_dto.dart';
import 'package:parish360_mobile/features/auth/data/models/user_dto.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  final String accessToken;
  final PermissionsDto permissions;
  final UserDto userInfo;

  LoginResponseDto({
    required this.accessToken,
    required this.permissions,
    required this.userInfo,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);
}