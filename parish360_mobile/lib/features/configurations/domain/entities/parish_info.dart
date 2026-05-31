import 'package:parish360_mobile/core/common/entities/place.dart';

class ParishInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? name;
  final String? denomination;
  final String? patron;
  final String? contact;
  final String? email;
  final DateTime? foundedDate;
  final bool? isActive;
  final String? website;
  final String? locale;
  final String? timezone;
  final String? currency;
  final Place? place;

  ParishInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.name,
    this.denomination,
    this.patron,
    this.contact,
    this.email,
    this.foundedDate,
    this.isActive,
    this.website,
    this.locale,
    this.timezone,
    this.currency,
    this.place,
  });

  factory ParishInfo.fromJson(Map<String, dynamic> json) {
    return ParishInfo(
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
      denomination: json['denomination'] as String?,
      patron: json['patron'] as String?,
      contact: json['contact'] as String?,
      email: json['email'] as String?,
      foundedDate: json['founded_date'] != null
          ? DateTime.parse(json['founded_date'] as String)
          : null,
      isActive: json['is_active'] as bool?,
      website: json['website'] as String?,
      locale: json['locale'] as String?,
      timezone: json['timezone'] as String?,
      currency: json['currency'] as String?,
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
      'name': name,
      'denomination': denomination,
      'patron': patron,
      'contact': contact,
      'email': email,
      'founded_date': foundedDate?.toIso8601String(),
      'is_active': isActive,
      'website': website,
      'locale': locale,
      'timezone': timezone,
      'currency': currency,
      'place': place?.toJson(),
    };
  }
}
