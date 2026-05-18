class MiscellaneousInfo {
  final String? id;
  final String? createdBy;
  final DateTime? createdAt;
  final String? updatedBy;
  final DateTime? updatedAt;
  final String? commentedBy;
  final String? comment;

  MiscellaneousInfo({
    this.id,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.commentedBy,
    this.comment,
  });

  factory MiscellaneousInfo.fromJson(Map<String, dynamic> json) {
    return MiscellaneousInfo(
      id: json['id'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      commentedBy: json['commented_by'] as String?,
      comment: json['comment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_by': updatedBy,
      'updated_at': updatedAt?.toIso8601String(),
      'commented_by': commentedBy,
      'comment': comment,
    };
  }
}
