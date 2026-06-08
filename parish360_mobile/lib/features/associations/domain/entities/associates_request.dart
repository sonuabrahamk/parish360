class AssociatesRequest {
  final List<String>? associates;

  AssociatesRequest({this.associates});

  factory AssociatesRequest.fromJson(Map<String, dynamic> json) {
    return AssociatesRequest(associates: json['associates'] as List<String>?);
  }

  Map<String, dynamic> toJson() {
    return {'associates': associates};
  }
}
