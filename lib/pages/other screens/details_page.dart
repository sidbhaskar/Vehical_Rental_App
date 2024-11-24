import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rental_app_assignment/widgets/specs_box.dart';

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

  void copyToClipboard() async {
    final String ownerNumber = vehicleData!['ownerNumber'].toString();
    await Clipboard.setData(ClipboardData(text: ownerNumber));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Number copied to clipboard')));
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
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Hero(
                          tag: widget.vehicleId,
                          child: Image.network(
                            height: 250,
                            vehicleData!['imageURL'],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicleData!['name'],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rating : 4.5',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '₹${vehicleData?['price']}/hr',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Text(
                            'Specifications',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SpecsBox(
                              specs: vehicleData!['seater'].toString(),
                              title: 'Seater',
                            ),
                            SpecsBox(
                              specs: vehicleData!['year'],
                              title: 'Year',
                            ),
                            SpecsBox(
                              specs: vehicleData!['range'],
                              title: 'Range',
                            ),
                            SpecsBox(
                              specs: vehicleData!['fuelCapacity'],
                              title: 'Fuel',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Text(
                        'Host',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${vehicleData?['owner']}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: copyToClipboard,
                            icon: Icon(Icons.call),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.message),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pickup & Return',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            vehicleData?['location'],
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Book Now',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
