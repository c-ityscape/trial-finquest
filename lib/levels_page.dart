import 'package:finquest_final/levels/level2/home_screen.dart';
import 'package:flutter/material.dart';
import 'game_layout.dart'; // Import GameLayout to navigate to it when a level is selected
import 'options_page.dart';
import 'levels/level1.dart'; // Import Level1

class LevelsPage extends StatelessWidget {
  final List<String> levels = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Hide the app bar
        child: AppBar(
          backgroundColor: Color(0xFF232325),
          elevation: 0,
        ),
      ),
      backgroundColor: Color(0xFF232325),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to OptionsPage when menu icon is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OptionsPage()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 6.0, top: 6.0),
                child: Icon(
                  Icons.menu,
                  color: Color(0xFFD9D9D9),
                  size: 30.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                SizedBox(
                  width: 2,
                ),
                Text(
                  "LET'S GO!",
                  style: TextStyle(
                    fontFamily: 'SDDystopianDemo',
                    fontSize: 64.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        color: Color(0xFF0CFFFF),
                        blurRadius: 10,
                      ),
                      Shadow(
                        offset: Offset(-2, 2),
                        color: Color(0xFA00FF),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 1,
                )
              ],
            ),
            SizedBox(height: 4.0),
            Container(
              height: 550.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: _buildLevelCard(context, levels[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, String level) {
    return GestureDetector(
      onTap: () {
        if (level == 'Level 1') {
          // Navigate to Level1 when Level 1 is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Level1()),
          );
        } else if (level == 'Level 2') {
          // Navigate to Level1 when Level 1 is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // Navigate to GameLayout when other levels are tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameLayout(level)),
          );
        }
      },
      child: Container(
        width: 369.0,
        height: 512.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.0),
          gradient: RadialGradient(
            colors: [
              Color(0xFF3F3F3F),
              Color(0xFF161617),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(11, 4),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _getImageForLevel(level),
              width: 200.0, // Adjust as needed
              height: 200.0, // Adjust as needed
            ),
            SizedBox(height: 55.0),
            Text(
              level,
              style: TextStyle(
                fontSize: 32.0,
                fontFamily: 'DigitalNumbers',
                color: Color(0xFFA6A6A6),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (level == 'Level 1') {
                  // Navigate to Level1 when Level 1 PLAY is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Level1()),
                  );
                } else if (level == 'Level 2') {
                  // Navigate to Level1 when Level 1 PLAY is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  // Navigate to GameLayout for other levels
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameLayout(level)),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF232325)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                elevation: MaterialStateProperty.all<double>(5),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                shadowColor: MaterialStateProperty.all<Color>(Color(0xFA00FF)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
              child: Text(
                'PLAY',
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'OdibeeSans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getImageForLevel(String level) {
    // Return image asset based on the level
    switch (level) {
      case 'Level 1':
        return 'assets/images/wallet_creditcard.png';
      case 'Level 2':
        return 'assets/images/phone_money.png';
      case 'Level 3':
        return 'assets/images/piggybank.png';
      case 'Level 4':
        return 'assets/images/investment.png';
      case 'Level 5':
        return 'assets/images/safe_money.png';
      default:
        return '';
    }
  }
}
