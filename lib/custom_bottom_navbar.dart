import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.08,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => onTap(0),
            child: Image.asset(
              'lib/assets/icons/home.png',
              width: screenWidth * 0.06,
              height: screenHeight * 0.06,
              color: selectedIndex == 0 ? Colors.red : const Color(0xFFA39D9D),
            ),
          ),
          GestureDetector(
            onTap: () => onTap(1),
            child: Image.asset(
              'lib/assets/icons/search.png',
              width: screenWidth * 0.06,
              height: screenHeight * 0.06,
              color: selectedIndex == 1 ? Colors.red : const Color(0xFFA39D9D),
            ),
          ),
          GestureDetector(
            onTap: () => onTap(2),
            child: Image.asset(
              'lib/assets/icons/contacts.png',
              width: screenWidth * 0.06,
              height: screenHeight * 0.06,
              color: selectedIndex == 2 ? Colors.red : const Color(0xFFA39D9D),
            ),
          ),
          GestureDetector(
            onTap: () => onTap(3),
            child: Image.asset(
              'lib/assets/icons/profile.png',
              width: screenWidth * 0.06,
              height: screenHeight * 0.06,
              color: selectedIndex == 3 ? Colors.red : const Color(0xFFA39D9D),
            ),
          ),
        ],
      ),
    );
  }
}
