import 'package:flutter/material.dart';

class CircularCategories extends StatelessWidget {
  final String categoryName;
  final String imageURL;
  const CircularCategories(
      {required this.categoryName, super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 18),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageURL),
              radius: 40,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(right: 18),
            child: Text(
              categoryName,
            ),
          ),
        ],
      ),
    );
  }
}
