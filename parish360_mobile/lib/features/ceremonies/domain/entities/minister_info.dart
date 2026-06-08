class MinisterInfo {
  final String? priest;
  final String? title;

  MinisterInfo({this.priest, this.title});

  factory MinisterInfo.fromJson(Map<String, dynamic> json) {
    return MinisterInfo(
      priest: json['priest'] as String?,
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'priest': priest, 'title': title};
  }
}
