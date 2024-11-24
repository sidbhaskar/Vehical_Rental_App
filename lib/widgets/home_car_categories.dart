import 'package:flutter/material.dart';
import 'package:rental_app_assignment/pages/other%20screens/details_page.dart';

class HomeCarCategories extends StatelessWidget {
  final String carName;
  final String carLocation;
  final int seatCount;
  final int price;
  final String imageURL;
  final String vehicleID;

  const HomeCarCategories({
    super.key,
    required this.carName,
    required this.carLocation,
    required this.seatCount,
    required this.price,
    required this.imageURL,
    required this.vehicleID,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              vehicleId: vehicleID,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 130,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Hero(
                  tag: vehicleID,
                  child: Image.network(
                    imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    carName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.black38,
                    ),
                    Text(
                      carLocation,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$seatCount seats',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹$price/hr',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
