import 'package:json_annotation/json_annotation.dart';

part 'permissions_dto.g.dart';

@JsonSerializable()
class PermissionsDto {
  final DataOwnerDto dataOwner;
  final ModulesDto modules;

  PermissionsDto({required this.dataOwner, required this.modules});
  factory PermissionsDto.fromJson(Map<String, dynamic> json) =>
      _$PermissionsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionsDtoToJson(this);
}

@JsonSerializable()
class DataOwnerDto {
  final List<String> diocese;
  final List<String> parish;
  final List<String> forane;

  DataOwnerDto({
    required this.diocese,
    required this.parish,
    required this.forane,
  });

  factory DataOwnerDto.fromJson(Map<String, dynamic> json) =>
      _$DataOwnerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DataOwnerDtoToJson(this);
}

@JsonSerializable()
class ModulesDto {
  final List<String> create;
  final List<String> view;
  final List<String> edit;
  final List<String> delete;

  ModulesDto({
    required this.create,
    required this.view,
    required this.edit,
    required this.delete,
  });

  factory ModulesDto.fromJson(Map<String, dynamic> json) =>
      _$ModulesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ModulesDtoToJson(this);
}
