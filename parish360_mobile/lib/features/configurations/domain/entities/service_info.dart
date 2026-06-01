import 'package:flutter/material.dart';

class ServiceInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? name;
  final String? type;
  final DateTime? date;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final double? amount;
  final String? currency;
  final double? conversionRate;

  ServiceInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.name,
    this.type,
    this.date,
    this.startTime,
    this.endTime,
    this.amount,
    this.currency,
    this.conversionRate,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) => ServiceInfo(
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
    type: json["type"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    startTime: json["start_time"] == null
        ? null
        : timeOfDayFromJson(json["start_time"]),
    endTime: json["end_time"] == null
        ? null
        : timeOfDayFromJson(json["end_time"]),
    amount: json["amount"]?.toDouble(),
    currency: json["currency"],
    conversionRate: json["conversion_rate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
    "name": name,
    "type": type,
    "date": date?.toIso8601String(),
    "start_time": timeOfDayToJson(startTime),
    "end_time": timeOfDayToJson(endTime),
    "amount": amount,
    "currency": currency,
    "conversion_rate": conversionRate,
  };

  static String? timeOfDayToJson(TimeOfDay? time) {
    if (time == null) return null;

    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:00';
  }

  static TimeOfDay? timeOfDayFromJson(String? timeStr) {
    if (timeStr == null) return null;

    final parts = timeStr.split(':');
    if (parts.length < 2) return null;

    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
