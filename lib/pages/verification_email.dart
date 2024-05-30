import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  bool isResendEmail = false;
  String verificationMessage = 'A verification email has been sent to your email address.';

  @override
  void initState() {
    super.initState();
    checkEmailVerified();
  }

  Future<void> checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;

    setState(() {
      isEmailVerified = user?.emailVerified ?? false;
      if (isEmailVerified) {
        verificationMessage = 'Your email is verified. Login to proceed.';
      }
    });
  }

  Future<void> resendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await user?.sendEmailVerification();
      setState(() {
        isResendEmail = true;
        verificationMessage = 'A new verification email has been sent. Please check your inbox.';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send verification email. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification', style: TextStyle(color: Colors.black)), // Set app bar title color to white
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                verificationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white), // Set text color to white
              ),
              SizedBox(height: 20),
              if (!isEmailVerified) ...[
                ElevatedButton(
                  onPressed: () async {
                    await checkEmailVerified();
                    if (isEmailVerified) {
                      Navigator.pushReplacementNamed(context, '/main'); // Change '/main' to your main screen route
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Email not verified yet. Please check your inbox.')),
                      );
                    }
                  },
                  child: Text('I have verified my email', style: TextStyle(color: Colors.black)), // Set button text color to white
                ),
                SizedBox(height: 20),
                if (!isResendEmail)
                  ElevatedButton(
                    onPressed: () => resendVerificationEmail(),
                    child: Text('Resend verification email', style: TextStyle(color: Colors.black)), // Set button text color to white
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
