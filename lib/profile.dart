import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232325),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Adjusted the spacing
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, top: 20), // Adjusted the position
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FutureBuilder<DocumentSnapshot>(
                future: _fetchUserData(), // Fetch user data asynchronously
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No data available');
                  } else {
                    // Extract user data
                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final username = userData['username'];
                    final email = userData['email'];
                    final score = userData['score'];

                    return Container(
                      width: 314,
                      height: 667,
                      decoration: BoxDecoration(
                        color: const Color(0xFF232325),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(97),
                          bottomRight: Radius.circular(97),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.25),
                            offset: const Offset(-6, -6),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.25),
                            offset: const Offset(10, 9),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Image.asset(
                            'assets/images/face.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 40),
                          Text(
                            username,
                            style: const TextStyle(
                              fontFamily: 'NotoSansTamil',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'email',
                            style: const TextStyle(
                              fontFamily: 'NotoSansTamil',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Container(
                            width: 271,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF232325),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFFFFFFF).withOpacity(0.2),
                                  offset: const Offset(0, -5),
                                  blurRadius: 7,
                                  spreadRadius: -1,
                                ),
                                BoxShadow(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Text(
                                email,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 23),
                          Text(
                            'score',
                            style: const TextStyle(
                              fontFamily: 'NotoSansTamil',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Container(
                            width: 271,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF232325),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFFFFFFF).withOpacity(0.2),
                                  offset: const Offset(0, -5),
                                  blurRadius: 7,
                                  spreadRadius: -1,
                                ),
                                BoxShadow(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Text(
                                '$score',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DocumentSnapshot> _fetchUserData() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve user data from Firestore
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
    } else {
      throw Exception('User not found');
    }
  }
}
