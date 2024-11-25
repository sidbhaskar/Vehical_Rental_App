import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_app_assignment/widgets/home_car_categories.dart';
import 'package:rental_app_assignment/widgets/search_result_bottomsheet.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final TextEditingController _searchController = TextEditingController();
  void _showSearchResults(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CustomBottomSheet(
          fieldName: 'name',
          searchQuery: _searchController.text,
        );
        // return DraggableScrollableSheet(
        //   initialChildSize: 1.0,
        //   minChildSize: 1.0,
        //   maxChildSize: 1.0,
        //   builder: (context, scrollController) {
        //     return SingleChildScrollView(
        //       controller: scrollController,
        //       child: SafeArea(
        //         child: Column(
        //           children: [
        //             Row(
        //               children: [
        //                 IconButton(
        //                   onPressed: () {
        //                     Navigator.pop(context);
        //                   },
        //                   icon: Icon(
        //                     Icons.close_rounded,
        //                     size: 35,
        //                   ),
        //                 ),
        //                 Expanded(
        //                   child: Text(
        //                     "Results: ${_searchController.text}",
        //                     style: TextStyle(
        //                       fontSize: 18,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             StreamBuilder(
        //               stream: FirebaseFirestore.instance
        //                   .collection('vehicles')
        //                   .where("name",
        //                       isEqualTo: _searchController.text.trim())
        //                   .snapshots(),
        //               builder: (context, snapshot) {
        //                 if (snapshot.connectionState ==
        //                     ConnectionState.waiting) {
        //                   return Center(child: CircularProgressIndicator());
        //                 }
        //                 if (snapshot.hasError) {
        //                   return Center(
        //                       child: Text("Error: ${snapshot.error}"));
        //                 }
        //                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        //                   return Center(child: Text("No vehicles found."));
        //                 }

        //                 return ListView.builder(
        //                   shrinkWrap: true,
        //                   itemCount: snapshot.data!.docs.length,
        //                   itemBuilder: (context, index) {
        //                     final vehicle = snapshot.data!.docs[index].data()
        //                         as Map<String, dynamic>;

        //                     final carName = vehicle['name'];
        //                     final carLocation =
        //                         vehicle['location'] ?? 'Unknown Location';
        //                     final seatCount = vehicle['seater'] ?? 0;
        //                     final price = vehicle['price'] ?? 0;
        //                     final imageURL = vehicle['imageURL'] ?? '';
        //                     final vehicleID =
        //                         vehicle['vehicleID'] ?? 'Unknown ID';

        //                     return HomeCarCategories(
        //                       carName: carName,
        //                       carLocation: carLocation,
        //                       seatCount: seatCount,
        //                       price: price,
        //                       imageURL: imageURL,
        //                       vehicleID: vehicleID,
        //                     );
        //                   },
        //                 );
        //               },
        //             )
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.black45,
            size: 28,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _showSearchResults(context);
                }
              },
              decoration: InputDecoration(
                hintText: "Search vehicles...",
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 16, color: Colors.black38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
