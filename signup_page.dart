import 'package:flutter/material.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  final Function(String userName, String email, String password) onSignup;

  SignupPage({required this.onSignup});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  bool _validateEmail(String email) {
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 6; // Example: password must be at least 6 characters long
  }

  void _signup() {
    final userName = _userNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    if (!_validateEmail(email)) {
      setState(() {
        _errorMessage = 'Invalid email format';
      });
      return;
    }

    if (!_validatePassword(password)) {
      setState(() {
        _errorMessage = 'Password must be at least 6 characters long';
      });
      return;
    }

    widget.onSignup(userName, email, password);

    // Navigate to the LoginPage with the provided credentials
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          registeredEmail: email,
          registeredPassword: password,
          registeredUserName: userName,
          onLogin: (String userName, String email, String password) {
            // Handle login action if needed
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'User Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signup,
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
