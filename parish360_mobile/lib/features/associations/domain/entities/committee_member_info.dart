class CommitteeMemberInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? designation;
  final int? position;
  final String? name;
  final String? contact;
  final String? email;
  final String? associationId;

  CommitteeMemberInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.designation,
    this.position,
    this.name,
    this.contact,
    this.email,
    this.associationId,
  });

  factory CommitteeMemberInfo.fromJson(Map<String, dynamic> json) {
    return CommitteeMemberInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      designation: json['designation'] as String?,
      position: json['position'] as int?,
      name: json['name'] as String?,
      contact: json['contact'] as String?,
      email: json['email'] as String?,
      associationId: json['association_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'designation': designation,
      'position': position,
      'name': name,
      'contact': contact,
      'email': email,
      'association_id': associationId,
    };
  }
}
