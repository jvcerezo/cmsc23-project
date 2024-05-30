import 'dart:convert';
import 'package:elbigayan/models/donation_model.dart';

class DonationDrive {
  String? id;
  String title;
  String userId;
  List<Donation> donationList;

  DonationDrive({this.id, required this.title, required this.userId, required this.donationList});

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    var list = json['donationList'] as List;
    List<Donation> donations = list.map((donation) => Donation.fromJson(donation)).toList();

    return DonationDrive(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
      donationList: donations,
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
