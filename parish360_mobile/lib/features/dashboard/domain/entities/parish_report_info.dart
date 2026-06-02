class ParishReportInfo {
  final int? numberOfAssociations;
  final int? numberOfUnits;
  final int? numberOfFamilies;
  final int? numberOfMembers;

  ParishReportInfo({
    this.numberOfAssociations,
    this.numberOfUnits,
    this.numberOfFamilies,
    this.numberOfMembers,
  });

  factory ParishReportInfo.fromJson(Map<String, dynamic> json) {
    return ParishReportInfo(
      numberOfAssociations: json['number_of_associations'] != null
          ? int.parse(json['number_of_associations'].toString())
          : null,
      numberOfUnits: json['number_of_units'] != null
          ? int.parse(json['number_of_units'].toString())
          : null,
      numberOfFamilies: json['number_of_families'] != null
          ? int.parse(json['number_of_families'].toString())
          : null,
      numberOfMembers: json['number_of_members'] != null
          ? int.parse(json['number_of_members'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number_of_associations': numberOfAssociations,
      'number_of_units': numberOfUnits,
      'number_of_families': numberOfFamilies,
      'number_of_members': numberOfMembers,
    };
  }
}
