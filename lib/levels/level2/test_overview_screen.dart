import 'package:flutter/material.dart';
import 'result_screen.dart'; // Import the ResultScreen

class TestOverviewScreen extends StatelessWidget {
  final Map<int, String> selectedAnswers;
  final int totalQuestions;
  final int secondsRemaining;
  final String topicId; // Add topicId parameter

  TestOverviewScreen({
    required this.selectedAnswers,
    required this.totalQuestions,
    required this.secondsRemaining,
    required this.topicId, // Update constructor
  });

  @override
  Widget build(BuildContext context) {
    // Calculate number of answered questions
    int answeredQuestions = totalQuestions -
        selectedAnswers.values.where((value) => value.isNotEmpty).length;

    return Scaffold(
      backgroundColor: Color(0xFF23232F),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // Pop until the QuizScreen is reached
                      Navigator.popUntil(context, ModalRoute.withName('/quiz'));
                    },
                  ),
                  Text(
                    "$answeredQuestions out of $totalQuestions answered",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Remaining",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "${(secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(secondsRemaining % 60).toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            GridView.count(
              crossAxisCount: 4, // 4 columns
              crossAxisSpacing: 5.0, // Spacing between columns
              mainAxisSpacing: 5.0, // Spacing between rows
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable scrolling
              padding: EdgeInsets.all(20.0),
              children: List.generate(totalQuestions, (index) {
                String identifier = selectedAnswers[index] ??
                    ''; // Default to empty string if null
                Color backgroundColor =
                    identifier.isNotEmpty ? Colors.purple : Color(0xFF3B3B3E);
                return Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigate back to the quiz screen with the corresponding question number
                      // Pass the question number as an argument
                      Navigator.pop(context, index);
                    },
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Show the selected answers
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          selectedAnswers: selectedAnswers,
                          topicId: topicId,
                        ),
                      ),
                    );
                  },
                  child: Text("Complete"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Go back to the previous QuizScreen
                    Navigator.pop(context);
                  },
                  child: Text("Go Back"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
