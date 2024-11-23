import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatefulWidget {
  final String vehicleId;

  const DetailsPage({super.key, required this.vehicleId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isLoading = true;
  Map<String, dynamic>? vehicleData;

  @override
  void initState() {
    super.initState();
    fetchVehicleDetails();
  }

  Future<void> fetchVehicleDetails() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(widget.vehicleId)
          .get();

      if (doc.exists) {
        setState(() {
          vehicleData = doc.data() as Map<String, dynamic>;
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching vehicle details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
        centerTitle: true,
        // actions: [
        // IconButton(
        //   onPressed: () {
        //     setState(() {
        //       vehicleData?["isFav"] = !vehicleData?["isFav"];
        //     });
        //   },
        //   icon: Icon(
        //     vehicleData?["isFav"] == true
        //         ? Icons.favorite
        //         : Icons.favorite_border,
        //     color: vehicleData?["isFav"] == true ? Colors.red : null,
        //   ),
        // )
        // ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : vehicleData == null
              ? Center(
                  child: Text('Vehicle not found'),
                )
              : Column(
                  children: [
                    Hero(
                      tag: widget.vehicleId,
                      child: Image.network(
                        vehicleData!['imageURL'],
                      ),
                    ),
                    Text(vehicleData!['name'] ?? 'No name available'),
                    Text(
                      '₹${vehicleData?['price'] ?? 'Price not available'}/hr',
                    ),
                  ],
                ),
    );
  }
}
