class ServiceIntentionInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? bookedBy;
  final String? contact;
  final String? intention;
  final String? event;
  final String? serviceId;
  final String? status;
  final String? familyCode;

  ServiceIntentionInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.bookedBy,
    this.contact,
    this.intention,
    this.event,
    this.serviceId,
    this.status,
    this.familyCode,
  });

  factory ServiceIntentionInfo.fromJson(Map<String, dynamic> json) {
    return ServiceIntentionInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      bookedBy: json['booked_by'] as String?,
      contact: json['contact'] as String?,
      event: json['event'] as String?,
      intention: json['intention'] as String?,
      serviceId: json['service_id'] as String?,
      status: json['status'] as String?,
      familyCode: json['family_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'booked_by': bookedBy,
      'contact': contact,
      'event': event,
      'intention': intention,
      'service_id': serviceId,
      'status': status,
      'family_code': familyCode,
    };
  }
}
