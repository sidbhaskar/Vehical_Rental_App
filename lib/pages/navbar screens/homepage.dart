import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app_assignment/widgets/circular_categories.dart';
import 'package:rental_app_assignment/widgets/home_car_categories.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top content (fixed)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Location',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black45),
                          ),
                          Text(
                            'Jammu, Kunjwani',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            child: Icon(Icons.notifications),
                            radius: 24,
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            radius: 24,
                            child: Icon(Icons.person),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      color: Colors.black45,
                      size: 40,
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search your ride...",
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.black38),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 120,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('vehicles')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return CircularCategories(
                              categoryName:
                                  snapshot.data!.docs[index].data()['Catagory'],
                              imageURL:
                                  snapshot.data!.docs[index].data()['imageURL'],
                            );
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),

          // Draggable bottom sheet
          DraggableScrollableSheet(
            snap: true,
            shouldCloseOnMinExtent: true,
            initialChildSize: 0.55, // Initial height (40% of screen)
            minChildSize: 0.55, // Minimum height when collapsed
            maxChildSize:
                0.87, // Maximum height when expanded (stops at search bar)
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        'Top Rides',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Grid
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('vehicles')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Text('No data here');
                          }
                          return Expanded(
                            child: GridView.builder(
                              controller: scrollController,
                              padding: const EdgeInsets.all(18),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1 / 1.3,
                              ),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return HomeCarCategories(
                                  carName:
                                      snapshot.data!.docs[index].data()['Name'],
                                  carLocation: snapshot.data!.docs[index]
                                      .data()['Location'],
                                  price: snapshot.data!.docs[index]
                                      .data()['Price'],
                                  seatCount: snapshot.data!.docs[index]
                                      .data()['Seater'],
                                  imageURL: snapshot.data!.docs[index]
                                      .data()['imageURL'],
                                );
                              },
                            ),
                          );
                        }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
