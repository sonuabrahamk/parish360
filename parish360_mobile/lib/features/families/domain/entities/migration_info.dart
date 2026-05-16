import 'package:parish360_mobile/core/common/entities/place.dart';

class MigrationInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? migratedOn;
  final String? comment;
  final String? address;
  final String? parish;
  final DateTime? returnDate;
  final Place? place;
  final String? status;

  MigrationInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.migratedOn,
    this.comment,
    this.address,
    this.parish,
    this.returnDate,
    this.place,
    this.status,
  });

  factory MigrationInfo.fromJson(Map<String, dynamic> json) {
    return MigrationInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      migratedOn: json['migrated_on'] != null
          ? DateTime.parse(json['migrated_on'] as String)
          : null,
      comment: json['comment'] as String?,
      address: json['address'] as String?,
      parish: json['parish'] as String?,
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'] as String)
          : null,
      place: json['place'] != null
          ? Place.fromJson(json['place'] as Map<String, dynamic>)
          : null,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'migrated_on': migratedOn?.toIso8601String(),
      'comment': comment,
      'address': address,
      'parish': parish,
      'return_date': returnDate?.toIso8601String(),
      'place': place?.toJson(),
      'status': status,
    };
  }

}