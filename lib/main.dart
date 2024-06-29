import 'package:finquest_final/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'levels/level2/question_uploader.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await uploadQuestionsToFirestore();
  runApp(MyApp());
}

Future<void> uploadQuestionsToFirestore() async {
  await QuestionUploader.uploadLoanQuestions();
  await QuestionUploader.uploadStockQuestions();
  await QuestionUploader.uploadBankingQuestions();
  await QuestionUploader.uploadRealEstateQuestions();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3B3B3E),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Navigate to LoginPage on box press
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Material(
            elevation: 5, // Inner shadow effect
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(141.5),
              bottomRight: Radius.circular(141.5),
            ),
            color: Color(0xFF232325),
            child: Container(
              width: 283,
              height: 542,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Space between icon and text
                      Text(
                        'FINQUEST',
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'SignikaSC',
                          color: Color(0xFFA6A6A6),
                        ),
                      ),
                      SizedBox(width: 10),
                      Image.asset(
                        'assets/images/coins.png',
                        width: 34,
                        height: 35,
                        // Adjust the path as needed
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Join the quest, Discover Finance',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'SignikaSC',
                          color: Color(0xFFA6A6A6),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50), // Space from title to circles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Color(0xFFA6A6A6),
                      ),
                      SizedBox(width: 21), // Space between circles
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Color(0xFFA6A6A6),
                      ),
                      SizedBox(width: 21), // Space between circles
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Color(0xFFA6A6A6),
                      ),
                      SizedBox(width: 21), // Space between circles
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Color(0xFFA6A6A6),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
