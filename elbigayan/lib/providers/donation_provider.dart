import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elbigayan/api/donation_api.dart';

class DonationProvider with ChangeNotifier {
  final FirebaseDonationAPI firebaseService = FirebaseDonationAPI();
  late Stream<QuerySnapshot> _donationStream;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<String> _donationItems = [];

  DonationProvider() {
    fetchDonations();
  }

  Stream<QuerySnapshot> get donationStream => _donationStream;

  void fetchDonations() {
    _donationStream = firebaseService.getAllDonations();
    notifyListeners();
  }

  Future<void> submitDonation(BuildContext context) async {
    final donation = {
      'name': nameController.text,
      'weight': weightController.text,
      'address': addressController.text,
      'date': _selectedDate?.toIso8601String(),
      'time': _selectedTime?.format(context),
      'items': _donationItems,
    };

    try {
      final message = await firebaseService.addDonation(donation);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      clearFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void clearFields() {
    nameController.clear();
    weightController.clear();
    addressController.clear();
    _selectedDate = null;
    _selectedTime = null;
    _donationItems = [];
    notifyListeners();
  }

  void updateDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  void updateDonationItems(List<String> items) {
    _donationItems = items;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
