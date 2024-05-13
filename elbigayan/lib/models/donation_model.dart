import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Donation{
  final int userID;
  String? id;
  String category;
  String mode;
  double weight;
  Timestamp deliveryTime;
  String imageUrl;

  Donation({
    required this.userID,
    this.id,
    required this.category,
    required this.mode,
    required this.weight,
    required this.deliveryTime,
    required this.imageUrl
  });




}