import 'package:parish360_mobile/core/common/entities/place.dart';

class SacramentInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? type;
  final DateTime? date;
  final String? priest;
  final String? parish;
  final Place? place;

  SacramentInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.type,
    this.date,
    this.priest,
    this.parish,
    this.place,
  });

  factory SacramentInfo.fromJson(Map<String, dynamic> json) {
    return SacramentInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      type: json['type'] as String?,
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : null,
      priest: json['priest'] as String?,
      parish: json['parish'] as String?,
      place: json['place'] != null
          ? Place.fromJson(json['place'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'type': type,
      'date': date?.toIso8601String(),
      'priest': priest,
      'parish': parish,
      'place': place?.toJson(),
    };
  }

}