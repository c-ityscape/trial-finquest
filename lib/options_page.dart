import 'levels_page.dart';
import 'profile.dart';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import LoginPage to navigate to it
import 'custom_elevate_button.dart';
import 'about.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // Hide the app bar
        child: AppBar(
          backgroundColor: const Color(0xFF232325),
          elevation: 0,
        ),
      ),
      backgroundColor: const Color(0xFF232325),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 359,
            height: 841,
            decoration: BoxDecoration(
              color: const Color(0xFF232325),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFFFFF).withOpacity(0.2),
                  offset: const Offset(0, -5),
                  spreadRadius: -1,
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.25),
                  offset: const Offset(0, 4),
                  spreadRadius: 4,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  text: 'Profile',
                  onPressed: () {
                    // Navigate to ProfilePage
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                  },
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Levels',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LevelsPage()),
                      );
                    // Navigate to LevelsPage
                  },
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                    text: 'About',
                    onPressed: () {
                      // Navigate to AboutPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AboutPage()),
                      );
                    }),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Log Out',
                  onPressed: () {
                    // Navigate back to LoginPage
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoginPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
