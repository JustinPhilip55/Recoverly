import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'sign_up_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
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

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Stack(
        children: [
          // "Sign in your account" text with specific position and font size
          Positioned(
            left: 59,
            top: 242,
            child: const Text(
              "Sign in your account",
              style: TextStyle(
                fontSize: 26.72,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Email label with specific position, size, and font weight
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

          // Email input field with position, width, and height
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

          // Password label with specific position, size, and font weight
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

          // Password input field with position, width, and height
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

          // Sign In Button with specific position, size, color, and text
          Positioned(
            left: 60,
            top: 541,
            width: 288,
            height: 42,
            child: ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Fixed 'primary' to 'backgroundColor'
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Stack(
                children: [
                  Positioned(
                    left: 117,
                    top: 16,
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600, // Semi-bold text
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // "Or sign in with" text with specific position and size
          Positioned(
            left: 145,
            top: 630,
            child: const Text(
              "or sign in with",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Google Sign-In Button (using text instead of logo)
          Positioned(
            left: 60,
            top: 660,
            width: 288,
            height: 42,
            child: TextButton(
              onPressed: signInWithGoogle,
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Sign In with Google',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Sign-Up Text Button with specific position
          Positioned(
            left: 60,
            top: 600,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text('Don’t have an account? Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
