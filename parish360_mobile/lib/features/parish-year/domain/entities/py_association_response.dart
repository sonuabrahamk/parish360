import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';

class PyAssociationResponse {
  final String? id;
  final ParishYearInfo? parishYear;
  final AssociationInfo? association;

  PyAssociationResponse({this.id, this.parishYear, this.association});

  factory PyAssociationResponse.fromJson(Map<String, dynamic> json) {
    return PyAssociationResponse(
      id: json['id'] as String?,
      parishYear: json['parish_year'] != null
          ? ParishYearInfo.fromJson(json['parish_year'] as Map<String, dynamic>)
          : null,
      association: json['association'] != null
          ? AssociationInfo.fromJson(
              json['association'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parish_year': parishYear?.toJson(),
      'association': association?.toJson(),
    };
  }
}
