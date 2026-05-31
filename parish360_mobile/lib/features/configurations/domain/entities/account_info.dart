class AccountInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? name;
  final String? description;
  final String? type;
  final String? owner;
  final String? bankName;
  final String? accountNumber;
  final String? branch;
  final String? ifscCode;

  AccountInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.name,
    this.description,
    this.type,
    this.owner,
    this.bankName,
    this.accountNumber,
    this.branch,
    this.ifscCode,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
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
      owner: json['owner'] as String?,
      bankName: json['bank_name'] as String?,
      accountNumber: json['account_number'] as String?,
      branch: json['branch'] as String?,
      ifscCode: json['ifsc_code'] as String?,
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
      'owner': owner,
      'bank_name': bankName,
      'account_number': accountNumber,
      'branch': branch,
      'ifsc_code': ifscCode,
    };
  }
}
