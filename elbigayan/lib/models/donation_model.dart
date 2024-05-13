import 'dart:convert';

class Donation {
  final int userID;
  String? id;
  String category;
  String mode;
  double weight;
  String deliveryTime;
  String imageUrl;

  Donation(
      {required this.userID,
      this.id,
      required this.category,
      required this.mode,
      required this.weight,
      required this.deliveryTime,
      required this.imageUrl});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
        userID: json['userID'],
        id: json['id'],
        category: json['category'],
        mode: json['mode'],
        weight: json['weight'],
        deliveryTime: json['deliveryTime'],
        imageUrl: json['imageUrl']);
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'userID': donation.userID,
      'id': donation.id,
      'category': donation.category,
      'mode': donation.mode,
      'weight': donation.mode,
      'deliveryTime': donation.deliveryTime,
      'imageUrl': donation.imageUrl
    };
  }
}
