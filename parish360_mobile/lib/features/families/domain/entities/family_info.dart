class FamilyInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? familyCode;
  final String? familyName;
  final String? contact;
  final String? address;
  final bool? contactVerified;
  final DateTime? joinedDate;
  final String? unit;
  final String? headOfFamily;
  final String? parishId;

  FamilyInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.familyCode,
    this.familyName,
    this.contact,
    this.address,
    this.contactVerified,
    this.joinedDate,
    this.unit,
    this.headOfFamily,
    this.parishId,
  });

  factory FamilyInfo.fromJson(Map<String, dynamic> json) {
    return FamilyInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      familyCode: json['family_code'] as String?,
      familyName: json['family_name'] as String?,
      contact: json['contact'] as String?,
      address: json['address'] as String?,
      contactVerified: json['contact_verified'] as bool?,
      joinedDate: json['joined_date'] != null
          ? DateTime.parse(json['joined_date'] as String)
          : null,
      unit: json['unit'] as String?,
      headOfFamily: json['head_of_family'] as String?,
      parishId: json['parish_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'family_code': familyCode,
      'family_name': familyName,
      'contact': contact,
      'address': address,
      'contact_verified': contactVerified,
      'joined_date': joinedDate?.toIso8601String(),
      'unit': unit,
      'head_of_family': headOfFamily,
      'parish_id': parishId,
    };
  }

}