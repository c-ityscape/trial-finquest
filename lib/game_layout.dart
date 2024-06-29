import 'package:flutter/material.dart';

class GameLayout extends StatelessWidget {
  final String level;

  GameLayout(this.level);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232325),
      body: Container(
        width: 841,
        height: 348,
        decoration: BoxDecoration(
          color: Color(0xFF232325),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF9E8C8C).withOpacity(0.25),
              offset: Offset(-1, -4),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Color(0xFF050505).withOpacity(0.25),
              offset: Offset(13, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.pause),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    // Add functionality for pausing the game
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.settings),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    // Add functionality for settings
                  },
                ),
              ),
            ),
            Center(
              child: Text(
                'Game Content for $level',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}