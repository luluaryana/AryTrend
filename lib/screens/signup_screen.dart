import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();

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
                    SizedBox(height: 20),
                    _buildTextField(_userNameTextController, "Enter your Username", Icons.person_2_outlined, false),
                    const SizedBox(height: 20),
                    _buildTextField(_emailTextController, "Enter your Email", Icons.email_outlined, false),
                    const SizedBox(height: 20),
                    _buildTextField(_passwordTextController, "Enter your Password", Icons.lock_outline_rounded, true),
                    const SizedBox(height: 20),
                    _buildSignUpButton(context),
                    SizedBox(height: 20),
                    _buildBottomRow(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
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
      keyboardType: isPassword ? TextInputType.visiblePassword : (label.contains("Email") ? TextInputType.emailAddress : TextInputType.text),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () => _signUp(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.pink[400]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have account?", style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SigninScreen())),
          child: const Text(" Sign In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  void _signUp(BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text)
        .then(
      (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SigninScreen(),
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        print(error); // make sure you remove it after testing
        _showErrorSnackBar(context, error.toString());
      },
    );
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    String displayMessage = "An error occurred";
    if (errorMessage.contains("invalid-email")) {
      displayMessage = "Invalid email format";
    } else if (errorMessage.contains("email-already-in-use")) {
      displayMessage = "Email is already in use";
    } else if (errorMessage.contains("weak-password")) {
      displayMessage = "Weak password. Please enter at least 6 characters";
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
