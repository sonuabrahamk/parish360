import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? email;
  final String firstName;
  final String lastName;
  final String username;
  final String? contact;
  final String? password;
  final bool isActive;
  final DateTime? lastLogin;
  final bool? isTouAccepted;
  final bool? isResetPassword;
  final String? comment;
  final String? locale;
  final String? currency;
  final String? timezone;

  UserDto({
    required this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.contact,
    this.password,
    required this.isActive,
    this.lastLogin,
    this.isTouAccepted,
    this.isResetPassword,
    this.comment,
    this.locale,
    this.currency,
    this.timezone,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

}