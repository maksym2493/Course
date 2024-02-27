import 'package:final_project/data/categories.dart';
import 'package:final_project/data/materials.dart';
import 'package:final_project/screens/advice.dart';
import 'package:final_project/screens/education.dart';
import 'package:final_project/screens/settings.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const EducationScreen(materials: materials),
              ),
            ),
            child: Image.asset(
              'assets/images/education_ico.png',
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AdviceScreen(),
              ),
            ),
            child: Image.asset(
              'assets/images/advice_ico.png',
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => SettingsScreen(categories: categories),
              ),
            ),
            child: Image.asset(
              'assets/images/settings_ico.png',
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
}
