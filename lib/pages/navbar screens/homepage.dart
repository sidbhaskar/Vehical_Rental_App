import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app_assignment/widgets/circular_categories.dart';
import 'package:rental_app_assignment/widgets/home_car_categories.dart';
import 'package:rental_app_assignment/widgets/search_result_bottomsheet.dart';

import '../../widgets/searchbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black26, width: 1),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 24,
                              child: Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black26, width: 1),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 24,
                              child: Icon(
                                Icons.person_2_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Searchbar(),
              const SizedBox(height: 30),
              SizedBox(
                height: 120,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('vehicles')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final uniqueCategories = <String>{};

                    final docs = snapshot.data!.docs.where((doc) {
                      final category = doc.data()['catagory'] as String;
                      if (uniqueCategories.contains(category)) {
                        return false;
                      } else {
                        uniqueCategories.add(category);
                        return true;
                      }
                    }).toList();

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final category =
                              docs[index].data()['catagory'] as String;

                          return GestureDetector(
                            onTap: () {
                              // Use showModalBottomSheet to display the CustomBottomSheet
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return CustomBottomSheet(
                                    searchQuery: category,
                                    fieldName: 'catagory',
                                  );
                                },
                              );
                            },
                            child: CircularCategories(
                              categoryName: category,
                              imageURL: docs[index].data()['imageURL'],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          DraggableScrollableSheet(
            snap: true,
            shouldCloseOnMinExtent: true,
            initialChildSize: 0.58,
            minChildSize: 0.58,
            maxChildSize: 0.87,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
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
                                vehicleID: snapshot.data!.docs[index].id,
                                carName:
                                    snapshot.data!.docs[index].data()['name'],
                                carLocation: snapshot.data!.docs[index]
                                    .data()['location'],
                                price:
                                    snapshot.data!.docs[index].data()['price'],
                                seatCount:
                                    snapshot.data!.docs[index].data()['seater'],
                                imageURL: snapshot.data!.docs[index]
                                    .data()['imageURL'],
                              );
                            },
                          ),
                        );
                      },
                    ),
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
