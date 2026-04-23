import 'dart:io';

class Complaint {
  final String? id;
  final String title;
  final String description;
  final String category;

  final double? lat;
  final double? lng;
  final File? image;

  Complaint({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.lat,
    this.lng,
    this.image,
  });
}