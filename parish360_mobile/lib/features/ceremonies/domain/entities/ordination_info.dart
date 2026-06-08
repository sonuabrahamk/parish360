import 'package:parish360_mobile/core/common/entities/place.dart';

class OrdinationInfo {
  final String? religiousOrder;
  final String? seminaryName;
  final Place? seminaryAddress;
  final String? previousOrdinationType;
  final DateTime? previousOrdinationDate;
  final Place? previousOrdinationPlace;

  OrdinationInfo({
    this.religiousOrder,
    this.seminaryName,
    this.seminaryAddress,
    this.previousOrdinationType,
    this.previousOrdinationDate,
    this.previousOrdinationPlace,
  });

  factory OrdinationInfo.fromJson(Map<String, dynamic> json) {
    return OrdinationInfo(
      religiousOrder: json['religious_order'] as String?,
      seminaryName: json['seminary_name'] as String?,
      seminaryAddress: json['seminary_address'] != null
          ? Place.fromJson(json['seminary_address'])
          : null,
      previousOrdinationType: json['previous_ordination_type'] as String?,
      previousOrdinationDate: json['previous_ordination_date'] != null
          ? DateTime.parse(json['previous_ordination_date'] as String)
          : null,
      previousOrdinationPlace: json['previous_ordination_place'] != null
          ? Place.fromJson(json['previous_ordination_place'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'religious_order': religiousOrder,
      'seminary_name': seminaryName,
      'seminary_address': seminaryAddress?.toJson(),
      'previous_ordination_type': previousOrdinationType,
      'previous_ordination_date': previousOrdinationDate,
      'previous_ordination_place': previousOrdinationPlace?.toJson(),
    };
  }
}
