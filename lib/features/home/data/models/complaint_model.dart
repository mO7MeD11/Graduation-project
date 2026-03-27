import '../../domain/entities/complaint.dart';

class ComplaintModel extends Complaint {
  ComplaintModel({
    required super.id,
    required super.title,
    required super.description,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
    };
  }
}