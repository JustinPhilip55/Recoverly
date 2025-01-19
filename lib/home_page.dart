import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign_in.dart';
import 'edit_profile.dart';
import 'track_your_progress.dart';
import 'remainders.dart';
import 'your_medicines.dart';
import 'community_groups.dart';
import 'connect_to_smartwatch.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  Future<DocumentSnapshot> getUserData() async {
    User? user = _auth.currentUser;
    return await _firestore.collection('users').doc(user?.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => signOut(context),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found'));
          }

          var userData = snapshot.data!;
          String userName = userData['name'];
          String profilePicUrl = userData['profilePicUrl'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: profilePicUrl.isNotEmpty
                          ? NetworkImage(profilePicUrl)
                          : AssetImage(
                                  'assets/home_page_assets/images/default_profile_pic.png')
                              as ImageProvider,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()),
                            );
                          },
                          child: Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Navigation Buttons with Custom Icons
                _buildNavigationButton(
                  context,
                  'assets/home_page_assets/icons/progress_icon.png',
                  'Track your progress',
                  TrackYourProgressPage(),
                ),
                _buildNavigationButton(
                  context,
                  'assets/home_page_assets/icons/remainders_icon.png',
                  'Remainders',
                  RemaindersPage(),
                ),
                _buildNavigationButton(
                  context,
                  'assets/home_page_assets/icons/medicine_icon.png',
                  'Medicine',
                  YourMedicinesPage(),
                ),
                _buildNavigationButton(
                  context,
                  'assets/home_page_assets/icons/community_icon.png',
                  'Community Support',
                  CommunityGroupsPage(),
                ),
                _buildNavigationButton(
                  context,
                  'assets/home_page_assets/icons/smartwatch_icon.png',
                  'Connect to smartwatch',
                  ConnectToSmartwatchPage(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String iconPath,
      String text, Widget destinationPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
        icon: Image.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
        ),
      ),
    );
  }
}
