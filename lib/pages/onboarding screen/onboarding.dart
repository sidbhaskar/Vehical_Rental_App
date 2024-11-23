import 'package:flutter/material.dart';
import 'package:rental_app_assignment/pages/onboarding%20screen/signup_page.dart';

import 'login_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.7,
            width: screenWidth,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                ),
              );
            },
            child: Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
