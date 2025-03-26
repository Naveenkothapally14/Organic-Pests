import 'package:flutter/material.dart';
import 'details_page.dart';

class DiseasePage extends StatelessWidget {
  final String userName;
  final String userEmail;
  final List<Map<String, String>> diseases;

  DiseasePage({
    required this.userName,
    required this.userEmail,
    required this.diseases,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diseases'),
      ),
      body: ListView.builder(
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          final disease = diseases[index];
          return Card(
            child: ListTile(
              leading: Image.asset(disease['image']!),
              title: Text(disease['title']!),
              subtitle: Text(disease['symptoms']!),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DiseaseDetailPage(disease: disease),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
