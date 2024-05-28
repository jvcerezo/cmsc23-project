import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonationProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  List<String> donationItems = [];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void updateDonationItems(List<String> items) {
    donationItems = items;
    notifyListeners();
  }

  void updateDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  Future<void> submitDonation(BuildContext context) async {
    if (nameController.text.isEmpty ||
        weightController.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null ||
        donationItems.isEmpty) {
      throw Exception('Please fill in all the fields');
    }

    final donation = {
      'donorName': nameController.text,
      'donationWeight': weightController.text,
      'donationItems': donationItems,
      'deliveryAddress': addressController.text,
      'dateTime': selectedDate!.toIso8601String(),
      'time': selectedTime!.format(context),
    };

    await FirebaseFirestore.instance.collection('donations').add(donation);
  }

  void clearFields() {
    nameController.clear();
    weightController.clear();
    addressController.clear();
    donationItems = [];
    selectedDate = null;
    selectedTime = null;
    notifyListeners();
  }
}
