class Vehicle {
  final String vehicleId;
  final String bookedBy;
  final String bookingId;
  final String category;
  final int fuelCapacity;
  final String imageUrl;
  final bool isBooked;
  final bool isFav;
  final String location;
  final String name;
  final String owner;
  final String ownerNumber;
  final double price;
  final int range;
  final int seater;
  final int year;

  Vehicle({
    required this.vehicleId,
    required this.bookedBy,
    required this.bookingId,
    required this.category,
    required this.fuelCapacity,
    required this.imageUrl,
    required this.isBooked,
    required this.isFav,
    required this.location,
    required this.name,
    required this.owner,
    required this.ownerNumber,
    required this.price,
    required this.range,
    required this.seater,
    required this.year,
  });

  // Factory method to create a Vehicle object from Firestore document
  factory Vehicle.fromFirestore(Map<String, dynamic> data) {
    return Vehicle(
      vehicleId: data['vehicleId'] ?? '',
      bookedBy: data['bookedby'] ?? '',
      bookingId: data['bookingId'] ?? '',
      category: data['category'] ?? '',
      fuelCapacity: data['fuelcapacity'] ?? 0,
      imageUrl: data['imageURL'] ?? '',
      isBooked: data['isBooked'] ?? false,
      isFav: data['isFav'] ?? false,
      location: data['location'] ?? '',
      name: data['name'] ?? '',
      owner: data['owner'] ?? '',
      ownerNumber: data['ownerNumber'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      range: data['range'] ?? 0,
      seater: data['seater'] ?? 0,
      year: data['year'] ?? 0,
    );
  }

  // Method to convert a Vehicle object to Firestore document format
  Map<String, dynamic> toFirestore() {
    return {
      'vehicleId': vehicleId,
      'bookedby': bookedBy,
      'bookingId': bookingId,
      'category': category,
      'fuelcapacity': fuelCapacity,
      'imageURL': imageUrl,
      'isBooked': isBooked,
      'isFav': isFav,
      'location': location,
      'name': name,
      'owner': owner,
      'ownerNumber': ownerNumber,
      'price': price,
      'range': range,
      'seater': seater,
      'year': year,
    };
  }
}
