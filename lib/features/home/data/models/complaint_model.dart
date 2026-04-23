import 'dart:io';
import '../../domain/entities/complaint.dart';

class ComplaintModel extends Complaint {
  ComplaintModel({
    super.id,
    required super.title,
    required super.description,
    required super.category,
    super.lat,
    super.lng,
    super.image,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id']?.toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      lat: json['lat'] != null ? json['lat'] * 1.0 : null,
      lng: json['lng'] != null ? json['lng'] * 1.0 : null,
      // image مش بتيجي من API غالبًا
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "category": category,
      "lat": lat,
      "lng": lng,
    };
  }
}