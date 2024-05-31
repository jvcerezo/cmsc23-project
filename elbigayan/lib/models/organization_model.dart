class Organization {
  String id;
  String name;
  String about;
  bool isApproved;
  bool isAcceptingDonations;
  List<String> proofs;
  List<String> donationIDs;

  Organization({
    required this.id,
    required this.name,
    required this.about,
    required this.isApproved,
    required this.isAcceptingDonations,
    required this.proofs,
    required this.donationIDs,
  });

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      id: map['id'],
      name: map['name'],
      about: map['about'],
      isApproved: map['isApproved'],
      isAcceptingDonations: map['isAcceptingDonations'],
      proofs: List<String>.from(map['proofs']),
      donationIDs: List<String>.from(map['donationIDs']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'about': about,
      'isApproved': isApproved,
      'isAcceptingDonations': isAcceptingDonations,
      'proofs': proofs,
      'donationIDs': donationIDs,
    };
  }
}
