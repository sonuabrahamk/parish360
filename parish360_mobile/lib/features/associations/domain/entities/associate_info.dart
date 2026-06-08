class AssociateInfo {
  final String? id;
  final String? associationId;
  final String? associatesId;

  AssociateInfo({this.id, this.associationId, this.associatesId});

  factory AssociateInfo.fromJson(Map<String, dynamic> json) {
    return AssociateInfo(
      id: json['id'] as String?,
      associationId: json['association_id'] as String?,
      associatesId: json['associates_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'association_id': associationId,
      'associates_id': associatesId,
    };
  }
}
