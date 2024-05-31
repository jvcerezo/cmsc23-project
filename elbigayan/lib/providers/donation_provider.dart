import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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
  List<String> _uploadedImageUrls = [];

  DonationProvider() {
    fetchDonations();
  }

  Stream<QuerySnapshot> get donation => _donationStream;
  List<String> get uploadedImageUrls => _uploadedImageUrls;

  void fetchDonations() {
    _donationStream = firebaseService.getAllDonations();
    notifyListeners();
  }

  Future<void> submitDonation(BuildContext context) async {
    final donation = {
      'name': nameController.text,
      'weight': weightController.text,
      'date': _selectedDate?.toIso8601String(),
      'time': _selectedTime?.format(context),
      'items': _donationItems,
      'images': _uploadedImageUrls,
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
    _uploadedImageUrls = [];
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

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      try {
        String imageUrl = await _uploadImageToFirebase(imageFile);
        _uploadedImageUrls.add(imageUrl);
        notifyListeners();
      } catch (e) {
        print("Error uploading image: $e");
        throw Exception("Image upload failed: $e");
      }
    } else {
      print("No image selected.");
    }
  }

  Future<String> _uploadImageToFirebase(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('donation_images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = await storageRef.putFile(imageFile);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Upload error: $e");
      throw Exception("Image upload failed: $e");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void resetStream() {
    fetchDonations(); // Re-fetch the donations to reset the stream
  }

}
