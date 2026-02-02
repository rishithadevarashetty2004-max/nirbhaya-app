import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this line to use Firestore for storing user details
import 'login.dart';
import 'main.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  Future<void> _signUpWithEmail(BuildContext context) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save user details to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'email': emailController.text.trim(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } catch (e) {
      _showAlert(context, 'Error', 'Sign up failed: $e');
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled the sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } catch (e) {
      _showAlert(context, 'Error', 'Google sign-in failed: $e');
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        await FirebaseAuth.instance.signInWithCredential(credential);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else {
        _showAlert(context, 'Error', 'Facebook sign-in failed: ${result.message}');
      }
    } catch (e) {
      _showAlert(context, 'Error', 'Facebook sign-in failed: $e');
    }
  }

  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top Section with Rhombus, Icons, and Logo
                Container(
                  height: 72,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 24,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Navigates back to the previous screen
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 23,
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFF202020)),
                              ),
                              child: const Center(
                                child: Icon(Icons.check, size: 14, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 100),
                            const Text(
                              'Register',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Positioned(
                        right: 26,
                        top: 24,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 16, // Adjust the size as needed
                            ),
                            Icon(Icons.notifications, color: Colors.black, size: 16), // Adjust the size as needed
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFFE8E8E8)),

                // "Already have an account?" Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF202020),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1F7BF4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Email, Password, First Name, and Last Name Fields
                _buildTextField("Email address", controller: emailController),
                const SizedBox(height: 16),
                _buildTextField("Password", controller: passwordController, obscureText: true),
                const SizedBox(height: 16),
                _buildTextField("First name", controller: firstNameController),
                const SizedBox(height: 16),
                _buildTextField("Last name", controller: lastNameController),
                const SizedBox(height: 24),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F7BF4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () => _signUpWithEmail(context),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Divider with "or"
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFFE8E8E8))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: Color(0xFF484848),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0xFFE8E8E8))),
                  ],
                ),
                const SizedBox(height: 24),

                // Social Media Sign-Up Buttons (Facebook & Google)
                ElevatedButton.icon(
                  onPressed: () => _signInWithGoogle(context),
                  icon: Icon(FontAwesomeIcons.google, color: Colors.white),
                  label: Text('Sign up with Google', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 48),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _signInWithFacebook(context),
                  icon: Icon(FontAwesomeIcons.facebook, color: Colors.white),
                  label: Text('Sign up with Facebook', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 48),
                  ),
                ),
                const SizedBox(height: 24),

                // Terms and Conditions
                const Text(
                  'By clicking Sign up, you agree to our Terms of Service and Privacy Policy.',
                  style: TextStyle(
                    color: Color(0xFF84818A),
                    fontSize: 12,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // reCAPTCHA and Privacy Policy Information
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Protected by reCAPTCHA and subject to the Prism ',
                        style: TextStyle(
                          color: Color(0xFF84818A),
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy ',
                        style: TextStyle(
                          color: Color(0xFF1F7BF4),
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                          color: Color(0xFF84818A),
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: 'Terms of Service.',
                        style: TextStyle(
                          color: Color(0xFF1F7BF4),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, {bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
