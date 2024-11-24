import 'package:flutter/material.dart';

class SpecsBox extends StatelessWidget {
  final String specs;
  final String title;
  const SpecsBox({super.key, required this.specs, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, top: 10),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title:",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            Text(
              specs,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
