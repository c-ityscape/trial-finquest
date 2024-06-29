import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'quiz_screen.dart'; // Import your quiz screen file

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> topics = [
    {"name": "Banking", "image": "assets/images/banking.png", "docId": "bk001"},
    {"name": "Stock", "image": "assets/images/stock.png", "docId": "stk001"},
    {
      "name": "Real Estate",
      "image": "assets/images/real_estate.png",
      "docId": "re001"
    },
    {
      "name": "Loan",
      "image": "assets/images/hand_money.png",
      "docId": "loan001"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF232325), Color(0xFF272925)],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              "Hello Friend!",
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "What do you want to learn today?",
              style: GoogleFonts.poppins(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF3b3b3e),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: topics.map((topic) {
                      return GestureDetector(
                        onTap: () {
                          _fetchQuestions(topic['docId'], context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    topic["image"],
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    topic["name"],
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.timer, color: Colors.white),
                                    SizedBox(width: 5.0),
                                    Text(
                                      "5 min",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 20.0),
                                    Icon(Icons.question_answer,
                                        color: Colors.white),
                                    SizedBox(width: 5.0),
                                    Text(
                                      "10 questions",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchQuestions(String docId, BuildContext context) {
    FirebaseFirestore.instance
        .collection('question_papers')
        .doc(docId)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        List<Map<String, dynamic>> questions = [];
        docSnapshot.data()!.forEach((key, value) {
          if (key == 'questions') {
            questions = List<Map<String, dynamic>>.from(value);
          }
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(
              questions: questions,
              topicId: docId, // Pass the docId as the topicId
            ),
          ),
        );
      } else {
        print('Document does not exist');
      }
    }).catchError((error) {
      print('Error fetching document: $error');
    });
  }
}
