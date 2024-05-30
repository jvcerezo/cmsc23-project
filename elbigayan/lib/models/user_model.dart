class CustomUser {
  String id;
  String name;
  String username;
  String contactNo;
  String address;
  bool isApproved;
  String role;
  String orgName;
  String aboutOrg;
  String? proofOfLegitimacy; // Assuming the proof of legitimacy is stored as a URL

  CustomUser({
    required this.id,
    required this.name,
    required this.username,
    required this.contactNo,
    required this.address,
    required this.isApproved,
    required this.role,
    required this.orgName,
    required this.aboutOrg,
    this.proofOfLegitimacy,
  });

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      contactNo: map['contactNo'],
      address: map['address'],
      isApproved: map['isApproved'],
      role: map['role'],
      orgName: map['orgName'],
      aboutOrg: map['aboutOrg'],
      proofOfLegitimacy: map['proofOfLegitimacy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'contactNo': contactNo,
      'address': address,
      'isApproved': isApproved,
      'role': role,
      'orgName': orgName,
      'aboutOrg': aboutOrg,
      'proofOfLegitimacy': proofOfLegitimacy,
    };
  }
}
