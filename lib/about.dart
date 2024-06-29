import 'package:flutter/material.dart';
// Import OptionsPage to navigate to it

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232325),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Color(0xFFD9D9D9),
                    ),
                    onPressed: () {
                      // Navigate to OptionsPage
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 314,
                height: 667,
                decoration: BoxDecoration(
                  color: const Color(0xFF232325),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(97),
                    bottomRight: Radius.circular(97),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.25),
                      offset: const Offset(-6, -6),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.25),
                      offset: const Offset(10, 9),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'About',
                      style: TextStyle(
                        fontFamily: 'ShareTechMono',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 62),
                    Container(
                      width: 271,
                      height: 322,
                      decoration: BoxDecoration(
                        color: const Color(0xFF232325),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFFFFF).withOpacity(0.2),
                            offset: const Offset(0, -5),
                            blurRadius: 7,
                            spreadRadius: -1,
                          ),
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: const Text(
                        "Welcome to the Financial Literacy Game! Enhance financial knowledge with interactive game levels on taxes, banking, and scams. Explore educational content, track progress, and learn scam prevention. Empowering users with vital financial skills. Join the journey to financial literacy within the app!",
                        style: TextStyle(
                          fontFamily: 'NotoSerifTamilSlanted',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
