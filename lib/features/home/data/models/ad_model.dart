class AdModel {
  final String id;
  final String title;
  final String imageUrl;
  final bool isActive;
  final DateTime createdAt;

  AdModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}