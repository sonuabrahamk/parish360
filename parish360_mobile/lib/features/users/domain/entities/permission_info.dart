class PermissionInfo {
  final String? id;
  final String? name;
  final String? description;
  final String? module;
  final String? permissionType;

  PermissionInfo({
    this.id,
    this.name,
    this.description,
    this.module,
    this.permissionType,
  });

  factory PermissionInfo.fromJson(Map<String, dynamic> json) {
    return PermissionInfo(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      module: json['module'] as String?,
      permissionType: json['permission_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'module': module,
      'permission_type': permissionType,
    };
  }
}
