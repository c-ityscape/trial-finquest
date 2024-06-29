import 'package:finquest_final/levels/level2/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class ResultScreen extends StatefulWidget {
  final Map<int, String> selectedAnswers;
  final String topicId;

  ResultScreen({
    Key? key,
    required this.selectedAnswers,
    required this.topicId,
  }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Map<int, bool> results;
  bool isLoading = true;
  List<Map<String, dynamic>> questionDetails = [];
  Future<int> getUserScore() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        int userScore = userData['score'] ?? 0;
        return userScore;
      }
    }

    return 0;
  }

  Future<void> updateUserScore(int additionalScore) async {
    try {
      // Get the current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Retrieve user's current score from Firestore
      int userScore = await getUserScore();

      // Calculate total score
      int totalScore = userScore + additionalScore;

      // Update the user's score in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'score': totalScore,
      });

      print('User score updated successfully.');
    } catch (error) {
      print('Error updating user score: $error');
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    calculateResults();
  }

  void calculateResults() {
    // Initialize results map
    Map<int, bool> calculatedResults = {};

    // Set a timeout for 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      // Check if results are still loading
      if (isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    });

    // Fetch correct answers from Firestore using the topicId
    FirebaseFirestore.instance
        .collection('question_papers')
        .doc(widget.topicId)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        List<dynamic> questions = docSnapshot['questions'];
        for (int i = 0; i < questions.length; i++) {
          String correctAnswer = questions[i]['correct_answer'];
          String question = questions[i]['question'];
          List<dynamic> answers = questions[i]['answers'];
          Map<String, dynamic> questionDetail = {
            'question': question,
            'correct_answer': correctAnswer,
            'answers': answers
          };
          questionDetails.add(questionDetail);
          String? selectedAnswer =
              widget.selectedAnswers[i]; // Question numbers start from 1
          bool isCorrect = selectedAnswer == correctAnswer;
          calculatedResults[i + 1] = isCorrect; // Question numbers start from 1
        }
        setState(() async {
          results = calculatedResults;
          isLoading = false;
          // Calculate total score
          int totalScore =
              (results?.values.where((element) => element).length ?? 0) * 100;

// Update total score in Firestore
          await updateUserScore(totalScore);
        });
      }
    }).catchError((error) {
      print('Error fetching correct answers: $error');
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232325),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70),
                    Text(
                      'Congratulations',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      'You have ${results?.values.where((element) => element).length ?? 0} points',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Tap below question numbers to view correct answers',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 25),
                    Expanded(
                      child: GridView.builder(
                        itemCount: questionDetails.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print(
                                  'Answers: ${questionDetails[index]['answers']}');
                              // Handle onTap to display question, possible answers, and correct answer
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xFF3B3B3E),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (questionDetails.isNotEmpty &&
                                            questionDetails[index] != null)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Question ${index + 1}:',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Question: ${questionDetails[index]['question']}', // Display question
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(height: 8),
                                              // Display possible answers if available
                                              if (questionDetails[index]
                                                          ['answers'] !=
                                                      null &&
                                                  questionDetails[index]
                                                              ['answers']
                                                          .length >=
                                                      4)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    for (int i = 0; i < 4; i++)
                                                      Text(
                                                        '${String.fromCharCode(97 + i)}. ${questionDetails[index]['answers'][i]}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                  ],
                                                ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Correct Answer: ${questionDetails[index]['correct_answer']}', // Display correct answer
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        if (questionDetails.isEmpty)
                                          Text(
                                            'No question details available',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: results[index + 1] == true
                                    ? Colors.green // Correct answer color
                                    : results[index + 1] == false
                                        ? Colors.red // Incorrect answer color
                                        : Colors.white, // Default color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigate back to the HomeScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: Text('Go Home'),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
