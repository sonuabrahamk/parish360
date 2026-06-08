class WitnessInfo {
  final String? name;
  final String? relation;
  final String? parish;
  final String? contact;

  WitnessInfo({this.name, this.relation, this.parish, this.contact});

  factory WitnessInfo.fromJson(Map<String, dynamic> json) {
    return WitnessInfo(
      name: json['name'] as String?,
      relation: json['relation'] as String?,
      parish: json['parish'] as String?,
      contact: json['contact'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relation': relation,
      'parish': parish,
      'contact': contact,
    };
  }
}
