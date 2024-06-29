import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'test_overview_screen.dart'; // Import the TestOverviewScreen

class QuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final String topicId; // Add topicId parameter

  QuizScreen({required this.questions, required this.topicId});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Timer _timer; // Change the declaration to not nullable

  int _currentQuestionIndex = 0;
  Map<String, dynamic> _currentQuestion = {};
  String? _selectedAnswer;

  int _secondsRemaining = 300; // 5 minutes

  // Dictionary to store selected answers for each question
  Map<int, String> _selectedAnswers = {
    for (int i = 0; i < 10; i++) i: '', // Initialize with empty strings
  };

  @override
  void initState() {
    super.initState();
    _startTimer();
    _loadQuestion();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer on dispose
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        // Timer finished, handle accordingly
      }
    });
  }

  void _loadQuestion() {
    setState(() {
      _currentQuestion = widget.questions[_currentQuestionIndex];
      _selectedAnswer = null;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _loadQuestion();
    } else {
      // Last question reached, navigate to the overview screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestOverviewScreen(
            selectedAnswers: _selectedAnswers,
            totalQuestions: widget.questions.length,
            secondsRemaining: _secondsRemaining,
            topicId: widget.topicId, // Pass the topic ID to TestOverviewScreen
          ),
        ),
      );
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _loadQuestion();
    }
  }

  void _submitQuiz() {
    // Display selected answers dictionary
    print(_selectedAnswers);
    // Navigate to the overview screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestOverviewScreen(
          selectedAnswers: _selectedAnswers,
          totalQuestions: widget.questions.length,
          secondsRemaining: _secondsRemaining,
          topicId: widget.topicId, // Pass the topic ID to TestOverviewScreen
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232325),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10), // Add space between icon and timer
                      Text(
                        "${_secondsRemaining ~/ 60}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}",
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Q${_currentQuestionIndex + 1}", // Display current question number
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF3b3b3e),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentQuestion['question'],
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Column(
                        children:
                            _currentQuestion['answers'].map<Widget>((answer) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 10,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedAnswer = answer['identifier'];
                                    _selectedAnswers[_currentQuestionIndex] =
                                        _selectedAnswer!;
                                    print('Selected Answer: $_selectedAnswer');
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return _selectedAnswer ==
                                              answer['identifier']
                                          ? Colors.purple
                                          : Colors.white;
                                    },
                                  ),
                                  textStyle: MaterialStateProperty.resolveWith<
                                      TextStyle>(
                                    (Set<MaterialState> states) {
                                      return TextStyle(
                                          fontSize: 16.0,
                                          color: _selectedAnswer ==
                                                  answer['identifier']
                                              ? Colors.white
                                              : Colors.purple);
                                    },
                                  ),
                                ),
                                child: Text(
                                  '${answer['identifier']}. ${answer['answer']}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16.0,
                                      color: _selectedAnswer ==
                                              answer['identifier']
                                          ? Colors.white
                                          : Colors.purple),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    child: ElevatedButton(
                      onPressed: _previousQuestion,
                      child: Text("Previous"),
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    child: ElevatedButton(
                      onPressed:
                          _currentQuestionIndex == widget.questions.length - 1
                              ? _submitQuiz
                              : _nextQuestion,
                      child: Text(
                          _currentQuestionIndex == widget.questions.length - 1
                              ? "Submit"
                              : "Next"),
                    ),
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
