import 'package:finquest_final/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B3B3E),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 736,
          decoration: BoxDecoration(
            color: const Color(0xFF232325),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(215),
              bottomRight: Radius.circular(215),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.25),
                spreadRadius: -5,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 69),
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'OdibeeSans',
                    color: Color(0xFFA6A6A6),
                  ),
                ),
                const SizedBox(height: 1),
                const Text(
                  'Please enter your email to reset your password.',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'PontanoSans',
                    color: Color(0xFFA6A6A6),
                  ),
                ),
                const SizedBox(height: 49),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'NotoSerifTamilSlanted',
                    color: Color(0xFF949497),
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
                        color: Colors.white.withOpacity(0.2),
                        spreadRadius: -5,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Color(0xFF949497)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim(),
                      );
                      // Navigate to login page after successful password reset
                    } catch (e) {
                      // Show error message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: Text("Failed to reset password: $e"),
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
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF232325),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(262, 40),
                  ),
                  child: const Text(
                    'RESET PASSWORD',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'OdibeeSans',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
