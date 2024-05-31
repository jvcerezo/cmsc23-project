import 'dart:convert';

class Donation {
  final int userID;
  String? id;
  double weight;
  String name;
  String address;
  String date;
  String time;
  List<String> items;
  String imageUrl;

  Donation(
      {required this.userID,
      this.id,
      required this.weight,
      required this.name,
      required this.address,
      required this.date,
      required this.time,
      required this.items,
      required this.imageUrl
      });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
        userID: json['userID'],
        id: json['id'],
        weight: json['weight'],
        name: json['name'],
        address: json['address'],
        date: json['date'],
        time: json['time'],
        imageUrl: json['imageUrl'],
        items: json['items']);
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'userID': donation.userID,
      'id': donation.id,
      'weight': donation.weight,
      'name': donation.name,
      'address': donation.address,
      'date': donation.date,
      'time': donation.time,
      'items': donation.items,
      'imageUrl': donation.imageUrl
    };
  }
}
