class AssociationInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? name;
  final String? description;
  final String? type;
  final String? director;
  final String? scope;
  final String? patron;
  final DateTime? foundedDate;
  final bool? active;

  AssociationInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.name,
    this.description,
    this.type,
    this.director,
    this.scope,
    this.patron,
    this.foundedDate,
    this.active,
  });

  factory AssociationInfo.fromJson(Map<String, dynamic> json) {
    return AssociationInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      director: json['director'] as String?,
      scope: json['scope'] as String?,
      patron: json['patron'] as String?,
      foundedDate: json['founded_date'] != null
          ? DateTime.parse(json['founded_date'] as String)
          : null,
      active: json['active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'name': name,
      'description': description,
      'type': type,
      'director': director,
      'scope': scope,
      'patron': patron,
      'founded_date': foundedDate?.toIso8601String(),
      'active': active,
    };
  }
}
