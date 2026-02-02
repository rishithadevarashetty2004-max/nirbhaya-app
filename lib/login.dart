import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dio/dio.dart';
import 'home_screen.dart';
import 'register.dart';
import 'main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  String email = '';
  String password = '';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> handleSignIn() async {
    try {
      setState(() {
        loading = true;
      });

      final response = await Dio().post(
        'YOUR_API_ENDPOINT',  // Replace with your API endpoint
        data: {
          'user_email': email,
          'user_password': password,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else {
        _showAlert('Error', 'Invalid email or password');
      }
    } catch (error) {
      _showAlert('Error', 'Something went wrong, please try again');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _signInWithGoogle() async {
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
      _showAlert('Error', 'Google sign-in failed: $e');
    }
  }

  Future<void> _signInWithFacebook() async {
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
        _showAlert('Error', 'Facebook sign-in failed: ${result.message}');
      }
    } catch (e) {
      _showAlert('Error', 'Facebook sign-in failed: $e');
    }
  }

  void _showAlert(String title, String message) {
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
      appBar: AppBar(
        title: Text('Sign In'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => setState(() {
                email = value;
              }),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) => setState(() {
                password = value;
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : handleSignIn,
              child: loading
                  ? CircularProgressIndicator(color: Colors.black)
                  : Text('Sign In'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _signInWithGoogle,
              icon: Icon(Icons.login),
              label: Text('Sign in with Google'),
            ),
            ElevatedButton.icon(
              onPressed: _signInWithFacebook,
              icon: Icon(Icons.login),
              label: Text('Sign in with Facebook'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text('Don\'t have an account? Sign up.'),
            ),
          ],
        ),
      ),
    );
  }
}
