class User {
  final String id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? email;
  final String firstName;
  final String lastName;
  final String username;
  final String? contact;
  final String? password;
  final bool isActive;
  final DateTime? lastLogin;
  final bool? isTouAccepted;
  final bool? isResetPassword;
  final String? comment;
  final String? locale;
  final String? currency;
  final String? timezone;

  User({
    required this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.contact,
    this.password,
    required this.isActive,
    this.lastLogin,
    this.isTouAccepted,
    this.isResetPassword,
    this.comment,
    this.locale,
    this.currency,
    this.timezone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'] as String,
      contact: json['contact'] as String?,
      password: json['password'] as String?,
      isActive: json['is_active'] as bool,
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'] as String)
          : null,
      isTouAccepted: json['is_tou_accepted'] as bool?,
      isResetPassword: json['is_reset_password'] as bool?,
      comment: json['comment'] as String?,
      locale: json['locale'] as String?,
      currency: json['currency'] as String?,
      timezone: json['timezone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'contact': contact,
      'password': password,
      'is_active': isActive,
      'last_login': lastLogin?.toIso8601String(),
      'is_tou_accepted': isTouAccepted,
      'is_reset_password': isResetPassword,
      'comment': comment,
      'locale': locale,
      'currency': currency,
      'timezone': timezone,
    };
  }

}