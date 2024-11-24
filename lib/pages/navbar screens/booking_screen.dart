import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/previous_rented_tile.dart';
import '../../widgets/rented_vehicle_card.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          title: const Text(
            'My Bookings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 3,
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                text: 'Current',
              ),
              Tab(
                icon: Icon(Icons.history),
                text: 'History',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCurrentBookingsTab(),
            _buildBookingHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentBookingsTab() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("bookings")
          .where("userID", isEqualTo: userId)
          .where("status", isEqualTo: "active")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                'No active bookings',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        final bookings = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("vehicles")
                  .doc(booking['vehicleID'])
                  .get(),
              builder: (context, vehicleSnapshot) {
                if (!vehicleSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final vehicle = vehicleSnapshot.data!;
                return CurrentRentalCard(
                  carName: vehicle['name'],
                  carImage: vehicle['imageURL'],
                  startDate: (booking['startDate'] as Timestamp).toDate(),
                  endDate: (booking['endDate'] as Timestamp).toDate(),
                  pricePerDay: vehicle['price'].toDouble(),
                  location: vehicle['location'],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildBookingHistoryTab() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("bookings")
          .where("userID", isEqualTo: userId)
          .where("status", isEqualTo: "completed")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.car_rental,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No previous bookings',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final bookings = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("vehicles")
                  .doc(booking['vehicleID'])
                  .get(),
              builder: (context, vehicleSnapshot) {
                if (!vehicleSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final vehicle = vehicleSnapshot.data!;
                return PreviousRentalTile(
                  carName: vehicle['name'],
                  carImage: vehicle['imageURL'],
                  startDate: (booking['startDate'] as Timestamp).toDate(),
                  endDate: (booking['endDate'] as Timestamp).toDate(),
                  totalCost: booking['totalPrice'].toDouble(),
                );
              },
            );
          },
        );
      },
    );
  }
}
