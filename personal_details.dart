import 'package:flutter/material.dart';

class PersonalDetailsPage extends StatelessWidget {
  final String userName;
  final String userEmail;

  PersonalDetailsPage({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Name: $userName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Email: $userEmail', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
