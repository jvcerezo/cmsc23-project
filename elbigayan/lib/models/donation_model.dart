import 'dart:convert';

class Donation {
  String? id;
  String address;
  String date;
  List<String> images;
  List<String> items;
  String name;
  String time;
  String weight;

  Donation({
    this.id,
    required this.address,
    required this.date,
    required this.images,
    required this.items,
    required this.name,
    required this.time,
    required this.weight,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'] as String?,
      address: json['address'] as String? ?? '',
      date: json['date'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)?.map((item) => item as String).toList() ?? [],
      items: (json['items'] as List<dynamic>?)?.map((item) => item as String).toList() ?? [],
      name: json['name'] as String? ?? '',
      time: json['time'] as String? ?? '',
      weight: json['weight'] as String? ?? '',
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'date': date,
      'images': images,
      'items': items,
      'name': name,
      'time': time,
      'weight': weight,
    };
  }
}
