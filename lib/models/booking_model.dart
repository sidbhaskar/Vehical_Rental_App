import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String bookingId;
  final DateTime bookingDateTime;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int totalHours;
  final double totalPrice;
  final String userId;
  final String vehicleId;

  Booking({
    required this.bookingId,
    required this.bookingDateTime,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalHours,
    required this.totalPrice,
    required this.userId,
    required this.vehicleId,
  });

  // Factory method to create a Booking object from Firestore document
  factory Booking.fromFirestore(Map<String, dynamic> data) {
    return Booking(
      bookingId: data['bookingId'] ?? '',
      bookingDateTime: (data['bookingdattime'] as Timestamp).toDate(),
      startDate: (data['startdate'] as Timestamp).toDate(),
      endDate: (data['enddate'] as Timestamp).toDate(),
      status: data['status'] ?? '',
      totalHours: data['totalhours'] ?? 0,
      totalPrice: (data['totalprice'] ?? 0.0).toDouble(),
      userId: data['userID'] ?? '',
      vehicleId: data['vehicleId'] ?? '',
    );
  }

  // Method to convert a Booking object to Firestore document format
  Map<String, dynamic> toFirestore() {
    return {
      'bookingId': bookingId,
      'bookingdattime': bookingDateTime,
      'startdate': startDate,
      'enddate': endDate,
      'status': status,
      'totalhours': totalHours,
      'totalprice': totalPrice,
      'userID': userId,
      'vehicleId': vehicleId,
    };
  }
}
