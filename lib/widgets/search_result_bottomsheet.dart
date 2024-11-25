import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_car_categories.dart';

class CustomBottomSheet extends StatelessWidget {
  final String searchQuery;
  final String fieldName;

  const CustomBottomSheet({
    super.key,
    required this.searchQuery,
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      size: 35,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Results: $searchQuery",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('vehicles')
                    .where(fieldName, isEqualTo: searchQuery.trim())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No vehicles found."));
                  }

                  return Expanded(
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final vehicle = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 18),
                                child: HomeCarCategories(
                                  vehicleID: snapshot.data!.docs[index].id,
                                  carName: vehicle['name'],
                                  carLocation: vehicle['location'],
                                  price: vehicle['price'],
                                  seatCount: vehicle['seater'],
                                  imageURL: vehicle['imageURL'],
                                ),
                              );
                            },
                            childCount: snapshot.data!.docs.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1 / 1.2,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
