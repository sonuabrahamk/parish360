class RoleInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? name;
  final String? description;
  final String? dataownerId;

  RoleInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.name,
    this.description,
    this.dataownerId,
  });

  factory RoleInfo.fromJson(Map<String, dynamic> json) {
    return RoleInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['udpated_at'] != null
          ? DateTime.parse(json['udpated_at'] as String)
          : null,
      updatedBy: json['udpated_by'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      dataownerId: json['dataowner_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'name': name,
      'description': description,
      'dataowner_id': dataownerId,
    };
  }
}
