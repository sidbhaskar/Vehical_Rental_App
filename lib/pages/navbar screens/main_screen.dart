import 'package:flutter/material.dart';
import 'package:rental_app_assignment/pages/navbar%20screens/booking_screen.dart';
import 'package:rental_app_assignment/pages/navbar%20screens/chat_screen.dart';
import 'package:rental_app_assignment/pages/navbar%20screens/fav_screen.dart';
import 'package:rental_app_assignment/pages/navbar%20screens/homepage.dart';
import 'package:rental_app_assignment/pages/navbar%20screens/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  final pages = [
    const Homepage(),
    const BookingScreen(),
    const FavScreen(),
    const ChatScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main page content
          pages[pageIndex],

          // Floating bottom navigation bar
          Positioned(
            bottom: 20, // Adjust this value for the vertical position
            left: 20, // Adjust for horizontal centering
            right: 20, // Adjust for horizontal centering
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    icon: pageIndex == 0
                        ? const Icon(
                            Icons.home_filled,
                            color: Colors.white,
                            size: 35,
                          )
                        : const Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                    icon: pageIndex == 1
                        ? const Icon(
                            Icons.work_rounded,
                            color: Colors.white,
                            size: 35,
                          )
                        : const Icon(
                            Icons.work_outline_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 2;
                      });
                    },
                    icon: pageIndex == 2
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 35,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 3;
                      });
                    },
                    icon: pageIndex == 3
                        ? const Icon(
                            Icons.chat_bubble,
                            color: Colors.white,
                            size: 35,
                          )
                        : const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 4;
                      });
                    },
                    icon: pageIndex == 4
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 35,
                          )
                        : const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
