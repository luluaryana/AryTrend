import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signin_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[100]!, Colors.pink[300]!],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.09, 20, 0),
                child: Column(
                  children: [
                    Image.asset(
                      "../assets/images/brand2.png",
                      fit: BoxFit.fitWidth,
                      width: 240,
                      height: 240,
                    ),
                    SizedBox(height: 40),
                    _buildTextField(_emailTextController, "Enter your Email", Icons.email_outlined),
                    const SizedBox(height: 40),
                    _buildResetPasswordButton(context),
                    SizedBox(height: 20),
                    _buildSignInLink(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: false,
      cursorColor: Colors.pink[700],
      style: TextStyle(color: Colors.pink[700]),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.pink[700]),
        labelText: label,
        labelStyle: TextStyle(color: Colors.pink[700]),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () => _resetPassword(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.pink[400]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        child: const Text(
          "Get New Password",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SigninScreen())),
      child: const Text(
        "Back to Sign In",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _resetPassword(BuildContext context) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailTextController.text)
        .then(
      (value) {
        _showSuccessSnackBar(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SigninScreen(),
          ),
        );
      },
    ).onError((error, stackTrace) {
      print("Error ${error.toString()}");
      _showErrorSnackBar(context, error.toString());
    });
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        duration: const Duration(seconds: 5),
        content: Text(
          "Password reset email sent. Please check your inbox.",
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    String displayMessage = "An error occurred while resetting the password";
    if (errorMessage.contains("user-not-found")) {
      displayMessage = "No user found with this email address";
    } else if (errorMessage.contains("invalid-email")) {
      displayMessage = "Invalid email format";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        duration: const Duration(seconds: 7),
        content: Text(
          displayMessage,
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
