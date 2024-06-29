import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication package
import 'forgot_password.dart'; // Import ForgotPasswordPage to navigate to it on "forgot password"
import 'signup_page.dart';
import 'levels_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  // Create controllers for the email and password text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // Hide the app bar
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      backgroundColor: const Color(0xFF949497),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Background Rectangular Shape
              Container(
                width: MediaQuery.of(context).size.width,
                height: 736,
                decoration: const BoxDecoration(
                  color: Color(0xFF232325),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(215),
                    bottomRight: Radius.circular(215),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 69),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 64,
                        fontFamily: 'OdibeeSans',
                        color: Color(0xFFA6A6A6),
                      ),
                    ),
                    const SizedBox(height: 69),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'email',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'NotoSerifTamilSlanted',
                                  color: Color(0xFF949497),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              )
                            ],
                          ),
                          const SizedBox(height: 1),
                          Container(
                            width: 271,
                            height: 69,
                            decoration: BoxDecoration(
                              color: const Color(0xFF232325),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      2, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: emailController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(color: Color(0xFF949497)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 39),
                          Row(
                            children: [
                              Text(
                                'password',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'NotoSerifTamilSlanted',
                                  color: Color(0xFF949497),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              )
                            ],
                          ),
                          const SizedBox(height: 1),
                          Container(
                            width: 271,
                            height: 69,
                            decoration: BoxDecoration(
                              color: const Color(0xFF232325),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      2, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(color: Color(0xFF949497)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 49), // Space for "Forgot password"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'forgot password?',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'NotoSerifTamilSlanted',
                                    color: Color(0xFFA6A6A6),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      36), // Space between lines and "OR" text
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    String email = emailController.text.trim();
                                    String password =
                                        passwordController.text.trim();
                                    // Sign in with email and password
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );
                                    // Navigate to LevelsPage if login successful
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LevelsPage()),
                                    );
                                  } catch (e) {
                                    // Handle login errors
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Error"),
                                          content: Text("Failed to login: $e"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFFA6A6A6)
                                              .withOpacity(0.79)),
                                  elevation:
                                      MaterialStateProperty.all<double>(5),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      Colors.black),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(102, 40),
                                  ),
                                ),
                                child: const Text(
                                  'login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OdibeeSans',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 33), // Space for line and "OR" text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 89,
                                height: 2,
                                color: const Color.fromARGB(255, 6, 6, 7),
                              ),
                              const SizedBox(
                                  width:
                                      36), // Space between lines and "OR" text
                              const Text(
                                'OR',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'ShareTechMono',
                                  color: Color(0xFF949497),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      36), // Space between "OR" text and line
                              Container(
                                width: 90,
                                height: 2,
                                color: const Color(0xFF78787B),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 22), // Space for "Don't have an account?"
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSerifTamilSlanted',
                              color: Color(0xFF949497),
                            ),
                          ),
                          const SizedBox(
                              height: 22), // Space for "Sign Up" button
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to SignUpPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF232325).withOpacity(0.79)),
                              elevation: MaterialStateProperty.all<double>(5),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                const Size(200, 40),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'OdibeeSans',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
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
