// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) =>
    LoginResponseDto(
      accessToken: json['accessToken'] as String,
      permissions: PermissionsDto.fromJson(
        json['permissions'] as Map<String, dynamic>,
      ),
      userInfo: UserDto.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDtoToJson(LoginResponseDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'permissions': instance.permissions,
      'userInfo': instance.userInfo,
    };
