import 'dart:convert';

class DonationDrive {
  String? id;
  String title;
  String userId;
  List<String> donationList; // Change the type to List<String>

  DonationDrive({this.id, required this.title, required this.userId, required this.donationList});

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    // The donationList is now a list of strings
    List<String> donationIds = List<String>.from(json['donationList'] as List<dynamic>);

    return DonationDrive(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
      donationList: donationIds,
    );
  }

  static List<DonationDrive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<DonationDrive>((dynamic d) => DonationDrive.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'donationList': donationList,
    };
  }
}
