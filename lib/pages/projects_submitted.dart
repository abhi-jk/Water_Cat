import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProjectsSubmitted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      // Handle the case where there is no signed-in user
      return Scaffold(
        body: Center(
          child: Text('No user signed in'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Projects Submitted'),
        ),
        body: FutureBuilder<DataSnapshot>(
          future: FirebaseDatabase.instance
              .reference()
              .child('users/$userId/projects')
              .once()
              .then((event) =>
                  event.snapshot), // Transform DatabaseEvent into DataSnapshot
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Get the projects
              Map<String, dynamic> projects = snapshot.data!.value is Map
                  ? Map<String, dynamic>.from(snapshot.data!.value as Map)
                  : {};

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Projects submitted: ${projects.length}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> projectData =
                            projects.values.elementAt(index) is Map
                                ? Map<String, dynamic>.from(
                                    projects.values.elementAt(index) as Map)
                                : {};

                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ExpansionTile(
                            title: Text(
                                'Project Name: ${projects.keys.elementAt(index)}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            children: projectData.entries.map((dataEntry) {
                              if (dataEntry.key == 'image') {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Image.network(dataEntry.value.toString()),
                                );
                              } else {
                                return ListTile(
                                  title: Text('${dataEntry.key}:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text('${dataEntry.value}'),
                                );
                              }
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      );
    }
  }
}
