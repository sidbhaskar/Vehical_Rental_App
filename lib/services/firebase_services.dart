import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/vehicles_model.dart';

class FirebaseServices {
  Future<List<Vehicle>> fetchVehicles() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    return snapshot.docs
        .map((doc) => Vehicle.fromFirestore(doc.data()))
        .toList();
  }

  // Fetch vehicles for a specific booking
  Future<List<Vehicle>> fetchCurrentBookings(String userId) async {
    final bookingSnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('userID', isEqualTo: userId)
        .where('status', isEqualTo: 'active') // Only active bookings
        .get();

    final vehicleIds =
        bookingSnapshot.docs.map((doc) => doc['vehicleID']).toList();

    if (vehicleIds.isEmpty) return [];

    final vehicleSnapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .where(FieldPath.documentId, whereIn: vehicleIds)
        .get();

    return vehicleSnapshot.docs
        .map((doc) => Vehicle.fromFirestore(doc.data()))
        .toList();
  }
}
