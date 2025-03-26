import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'login_page.dart';
import 'homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _registeredEmail;
  String? _registeredPassword;
  String? _registeredUserName;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('isLoggedIn');
    if (loggedIn != null && loggedIn) {
      setState(() {
        _isLoggedIn = true;
        _registeredUserName = prefs.getString('userName');
      });
    }
  }

  Future<void> _login(String userName, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', userName);
    setState(() {
      _isLoggedIn = true;
      _registeredUserName = userName;
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userName');
    setState(() {
      _isLoggedIn = false;
      _registeredUserName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
        actions: [
          if (_isLoggedIn)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _logout,
            ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.lightGreenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoggedIn)
                  Column(
                    children: [
                      Text(
                        'Welcome, $_registeredUserName!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                        onPressed: _logout,
                        child: Text('Logout'),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.emoji_people, size: 40, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Namaskar',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(
                                onSignup: (userName, email, password) {
                                  setState(() {
                                    _registeredUserName = userName;
                                    _registeredEmail = email;
                                    _registeredPassword = password;
                                  });
                                  Navigator.pop(context); // Go back to the home page after signing up
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                        registeredEmail: _registeredEmail,
                                        registeredPassword: _registeredPassword,
                                        registeredUserName: _registeredUserName,
                                        onLogin: _login,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: Text('Signup'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(
                                registeredEmail: _registeredEmail,
                                registeredPassword: _registeredPassword,
                                registeredUserName: _registeredUserName,
                                onLogin: _login,
                              ),
                            ),
                          );
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
