class ResourceInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? name;
  final String? description;
  final int? capacity;
  final double? amount;
  final String? currency;
  final double? conversionRate;
  final bool? isMassCompatible;
  final bool? isActive;

  ResourceInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.name,
    this.description,
    this.capacity,
    this.amount,
    this.currency,
    this.conversionRate,
    this.isMassCompatible,
    this.isActive,
  });

  factory ResourceInfo.fromJson(Map<String, dynamic> json) => ResourceInfo(
    id: json["id"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
    name: json["name"],
    description: json["description"],
    capacity: json["capacity"],
    amount: json["amount"]?.toDouble(),
    currency: json["currency"],
    conversionRate: json["conversion_rate"]?.toDouble(),
    isMassCompatible: json["is_mass_compatible"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
    "name": name,
    "description": description,
    "capacity": capacity,
    "amount": amount,
    "currency": currency,
    "conversion_rate": conversionRate,
    "is_mass_compatible": isMassCompatible,
    "is_active": isActive,
  };
}
