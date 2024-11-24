class User {
  final String id;
  final String name;
  final int age;
  final String phoneNumber;
  final String gender;
  final String drivingLicense;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.gender,
    required this.drivingLicense,
  });

  // Factory method to create a User object from Firestore document
  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      phoneNumber: data['phoneNumber'] ?? '',
      gender: data['gender'] ?? '',
      drivingLicense: data['drivingLicense'] ?? '',
    );
  }

  // Method to convert a User object to Firestore document format
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'drivingLicense': drivingLicense,
    };
  }
}
