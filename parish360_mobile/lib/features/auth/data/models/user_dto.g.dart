// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: json['id'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  createdBy: json['createdBy'] as String?,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  updatedBy: json['updatedBy'] as String?,
  email: json['email'] as String?,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  username: json['username'] as String,
  contact: json['contact'] as String?,
  password: json['password'] as String?,
  isActive: json['isActive'] as bool,
  lastLogin: json['lastLogin'] == null
      ? null
      : DateTime.parse(json['lastLogin'] as String),
  isTouAccepted: json['isTouAccepted'] as bool?,
  isResetPassword: json['isResetPassword'] as bool?,
  comment: json['comment'] as String?,
  locale: json['locale'] as String?,
  currency: json['currency'] as String?,
  timezone: json['timezone'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt?.toIso8601String(),
  'createdBy': instance.createdBy,
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'updatedBy': instance.updatedBy,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'username': instance.username,
  'contact': instance.contact,
  'password': instance.password,
  'isActive': instance.isActive,
  'lastLogin': instance.lastLogin?.toIso8601String(),
  'isTouAccepted': instance.isTouAccepted,
  'isResetPassword': instance.isResetPassword,
  'comment': instance.comment,
  'locale': instance.locale,
  'currency': instance.currency,
  'timezone': instance.timezone,
};
