class MemberInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? firstName;
  final String? contact;
  final bool? contactVerified;
  final DateTime? dob;
  final String? father;
  final String? mother;
  final String? relationship;

  MemberInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.firstName,
    this.contact,
    this.contactVerified,
    this.dob,
    this.father,
    this.mother,
    this.relationship,
  });

  factory MemberInfo.fromJson(Map<String, dynamic> json) {
    return MemberInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      firstName: json['first_name'] as String?,
      contact: json['contact'] as String?,
      contactVerified: json['contact_verified'] as bool?,
      dob: json['dob'] != null
          ? DateTime.parse(json['dob'] as String)
          : null,
      father: json['father'] as String?,
      mother: json['mother'] as String?,
      relationship: json['relationship'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'first_name': firstName,
      'contact': contact,
      'contact_verified': contactVerified,
      'dob': dob?.toIso8601String(),
      'father': father,
      'mother': mother,
      'relationship': relationship,
    };
  }

  MemberInfo copyWith({
    String? id,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? firstName,
    String? contact,
    bool? contactVerified,
    DateTime? dob,
    String? father,
    String? mother,
    String? relationship,
  }) {
    return MemberInfo(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      firstName: firstName ?? this.firstName,
      contact: contact ?? this.contact,
      contactVerified: contactVerified ?? this.contactVerified,
      dob: dob ?? this.dob,
      father: father ?? this.father,
      mother: mother ?? this.mother,
      relationship: relationship ?? this.relationship,
    );
  }
}