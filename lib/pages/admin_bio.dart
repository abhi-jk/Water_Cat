import 'package:flutter/material.dart';

class AdminBioPage extends StatelessWidget {
  // Dummy list of projects, replace with your actual data source
  final List<String> projects = [
    'Project 1',
    'Project 2',
    'Project 3',
    // Add more projects here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bio-Diversity Reported'),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index]),
            // Add more properties here as needed...
          );
        },
      ),
    );
  }
}
