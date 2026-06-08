class PyAssociationRequest {
  final List<String>? associations;

  PyAssociationRequest({this.associations});

  factory PyAssociationRequest.fromJson(Map<String, dynamic> json) {
    return PyAssociationRequest(
      associations: json['associations'] as List<String>,
    );
  }

  Map<String, dynamic> toJson() {
    return {'associations': associations};
  }
}
