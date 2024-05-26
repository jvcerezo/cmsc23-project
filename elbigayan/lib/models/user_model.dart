class User {
  String id;
  String name;
  String username;
  String contactNo;
  String address;
  bool isOrganization;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.contactNo,
    required this.address,
    required this.isOrganization,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      contactNo: map['contactNo'],
      address: map['address'],
      isOrganization: map['isOrganization'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'contactNo': contactNo,
      'address': address,
      'isOrganization': isOrganization,
    };
  }
}
