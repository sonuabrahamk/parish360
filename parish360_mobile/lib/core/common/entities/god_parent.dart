class GodParent {
  final String? name;
  final String? parish;
  final String? contact;
  final String? baptismName;

  GodParent({this.name, this.parish, this.contact, this.baptismName});

  factory GodParent.fromJson(Map<String, dynamic> json) {
    return GodParent(
      name: json['name'] as String?,
      parish: json['parish'] as String?,
      contact: json['contact'] as String?,
      baptismName: json['baptism_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'parish': parish,
      'contact': contact,
      'baptism_name': baptismName,
    };
  }
}
