import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Google SignIn instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Method for Google Sign-Up (Authentication)
  Future<void> signUpWithGoogle() async {
    try {
      // Start the Google sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in process
        return;
      }

      // Obtain the Google authentication credentials
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new Firebase credential using the Google sign-in credentials
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign up or sign in the user with the Firebase credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Navigate to the home page after a successful sign-in or sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Handle sign-up error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Method for regular email/password sign-up
  Future<void> signUpWithEmailAndPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Navigate to the home page after successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Stack(
        children: [
          // "Create an account" text with specific position and font size
          Positioned(
            left: 59,
            top: 242,
            child: const Text(
              "Create an account",
              style: TextStyle(
                fontSize: 26.72,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Email label
          Positioned(
            left: 60,
            top: 313,
            child: const Text(
              "Email",
              style: TextStyle(
                fontSize: 16,
                height: 1.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Email input field
          Positioned(
            left: 60,
            top: 337,
            width: 288,
            height: 42,
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),

          // Password label
          Positioned(
            left: 60,
            top: 426,
            child: const Text(
              "Password",
              style: TextStyle(
                fontSize: 16,
                height: 1.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Password input field
          Positioned(
            left: 60,
            top: 450,
            width: 288,
            height: 42,
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              obscureText: true,
            ),
          ),

          // Sign-Up Button (email/password)
          Positioned(
            left: 60,
            top: 541,
            width: 288,
            height: 42,
            child: ElevatedButton(
              onPressed: signUpWithEmailAndPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Sign Up with Email',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // "Or sign up with" text
          Positioned(
            left: 145,
            top: 630,
            child: const Text(
              "or sign up with",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Google Sign-Up Button
          Positioned(
            left: 60,
            top: 670,
            width: 288,
            child: ElevatedButton(
              onPressed: signUpWithGoogle,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Sign Up with Google',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // "Already have an account? Sign In" text
          Positioned(
            left: 60,
            top: 740,
            child: TextButton(
              onPressed: () {
                // Navigate to sign-in page
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Sign In'),
            ),
          ),
        ],
      ),
    );
  }
}
