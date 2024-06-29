import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController =
      TextEditingController(); // Add controller for username field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232325),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 433,
              height: 752,
              decoration: BoxDecoration(
                color: const Color(0xFF3B3B3E),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(216.5),
                  bottomRight: Radius.circular(216.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.25),
                    offset: const Offset(0, -4),
                    blurRadius: 4,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 69),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 64,
                      fontFamily: 'OdibeeSans',
                      color: Color(0xFFA6A6A6),
                    ),
                  ),
                  const SizedBox(height: 47),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'email',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'NotoSerifTamilSlanted',
                            color: Color(0xFFB6ACAC),
                          ),
                        ),
                        const SizedBox(height: 1),
                        Container(
                          width: 353,
                          height: 63,
                          decoration: BoxDecoration(
                            color: const Color(0xFF232325),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                offset: const Offset(0, -4),
                                blurRadius: 4,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.39),
                                offset: const Offset(0, 4),
                                blurRadius: 2.2,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: usernameController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'enter email',
                                hintStyle: TextStyle(color: Color(0xFFB6ACAC)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'password',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'NotoSerifTamilSlanted',
                            color: Color(0xFFB6ACAC),
                          ),
                        ),
                        const SizedBox(height: 1),
                        Container(
                          width: 353,
                          height: 63,
                          decoration: BoxDecoration(
                            color: const Color(0xFF232325),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                offset: const Offset(0, -4),
                                blurRadius: 4,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.39),
                                offset: const Offset(0, 4),
                                blurRadius: 2.2,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'enter password',
                                hintStyle: TextStyle(color: Color(0xFFB6ACAC)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'username',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'NotoSerifTamilSlanted',
                            color: Color(0xFFB6ACAC),
                          ),
                        ),
                        const SizedBox(height: 1),
                        Container(
                          width: 353,
                          height: 63,
                          decoration: BoxDecoration(
                            color: const Color(0xFF232323),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                offset: const Offset(0, -4),
                                blurRadius: 4,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.39),
                                offset: const Offset(0, 4),
                                blurRadius: 2.2,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller:
                                  displayNameController, // Connect to username controller
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'username',
                                hintStyle: TextStyle(color: Color(0xFFB6ACAC)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Material(
                    color: const Color(0xFF232325),
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () async {
                        try {
                          String username = usernameController.text.trim();
                          String password = passwordController.text.trim();
                          String displayName = displayNameController.text
                              .trim(); // Get username from controller

                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: username,
                            password: password,
                          );

                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .set({
                              'email': user.email,
                              'username':
                                  displayName, // Save username instead of email
                              'score': 1000, // Initialize score to 1000
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: Text("Failed to register user: $e"),
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
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'OdibeeSans',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
