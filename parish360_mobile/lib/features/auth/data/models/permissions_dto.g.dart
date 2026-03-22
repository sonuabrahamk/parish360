// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionsDto _$PermissionsDtoFromJson(Map<String, dynamic> json) =>
    PermissionsDto(
      dataOwner: DataOwnerDto.fromJson(
        json['dataOwner'] as Map<String, dynamic>,
      ),
      modules: ModulesDto.fromJson(json['modules'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PermissionsDtoToJson(PermissionsDto instance) =>
    <String, dynamic>{
      'dataOwner': instance.dataOwner,
      'modules': instance.modules,
    };

DataOwnerDto _$DataOwnerDtoFromJson(Map<String, dynamic> json) => DataOwnerDto(
  diocese: (json['diocese'] as List<dynamic>).map((e) => e as String).toList(),
  parish: (json['parish'] as List<dynamic>).map((e) => e as String).toList(),
  forane: (json['forane'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$DataOwnerDtoToJson(DataOwnerDto instance) =>
    <String, dynamic>{
      'diocese': instance.diocese,
      'parish': instance.parish,
      'forane': instance.forane,
    };

ModulesDto _$ModulesDtoFromJson(Map<String, dynamic> json) => ModulesDto(
  create: (json['create'] as List<dynamic>).map((e) => e as String).toList(),
  view: (json['view'] as List<dynamic>).map((e) => e as String).toList(),
  edit: (json['edit'] as List<dynamic>).map((e) => e as String).toList(),
  delete: (json['delete'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$ModulesDtoToJson(ModulesDto instance) =>
    <String, dynamic>{
      'create': instance.create,
      'view': instance.view,
      'edit': instance.edit,
      'delete': instance.delete,
    };
