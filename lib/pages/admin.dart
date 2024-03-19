import 'package:cwrdm/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  Map<String, String> labels = {
    'isApproved': 'Approval Status',
    'projectName': 'Project Name',
    'location': 'Location',
    'sampleDetails': 'Sample Details',
    'observation': 'Observation',
    'pH': 'pH',
    'alkaline': 'Alkaline',
    'hardness': 'Hardness',
    'chloride': 'Chloride',
    'tds': 'TDS',
    'iron': 'Iron',
    'ammonia': 'Ammonia',
    'nitrate': 'Nitrate',
    'phosphate': 'Phosphate',
    'resCl': 'Residual Chlorine',
    'waterlvl': 'Water Level',
    'remark': 'Remark',
    'image': 'Image',
    'auther': 'Auther',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('${adminEmail}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'A'.toUpperCase(),
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.query_stats_sharp),
              title: Text('Queries'),
              onTap: () {
                Navigator.pushNamed(context, '/adminQuery');
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Projects Submitted'),
              onTap: () {
                Navigator.pushNamed(context, '/submittedProjects');
              },
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('Issues'),
              onTap: () {
                Navigator.pushNamed(context, '/adminIssues');
              },
            ),
            ListTile(
              leading: Icon(Icons.nature),
              title: Text('Bio-Diversity'),
              onTap: () {
                Navigator.pushNamed(context, '/adminBio');
              },
            ),
            ListTile(
              leading: Icon(Icons.flood),
              title: Text('Flood Levels'),
              onTap: () {
                Navigator.pushNamed(context, '/adminfloodLevels');
              },
            ),
            ListTile(
              leading: Icon(Icons.waves),
              title: Text('Rainfall Levels'),
              onTap: () {
                Navigator.pushNamed(context, '/adminrainfall');
              },
            ),
            ListTile(
              leading: Icon(Icons.water_drop),
              title: Text('Ground Water Levels'),
              onTap: () {
                Navigator.pushNamed(context, '/admingroundwater');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<DataSnapshot>(
        future: FirebaseDatabase.instance
            .reference()
            .child('users')
            .once()
            .then((event) =>
                event.snapshot), // Transform DatabaseEvent into DataSnapshot
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Get the users
            Map<String, dynamic> users = snapshot.data!.value is Map
                ? Map<String, dynamic>.from(snapshot.data!.value as Map)
                : {};

            return Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'List of Users and their Projects',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> userData =
                        users.values.elementAt(index) is Map
                            ? Map<String, dynamic>.from(
                                users.values.elementAt(index) as Map)
                            : {};
                    Map<String, dynamic> projects = userData['projects'] is Map
                        ? Map<String, dynamic>.from(userData['projects'] as Map)
                        : {};

                    return Card(
                        margin: EdgeInsets.all(8.0),
                        child: projects.isNotEmpty
                            ? ExpansionTile(
                                title: Text('User Name: ${userData['name']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                children: projects.entries.map((entry) {
                                  Map<String, dynamic> projectData =
                                      entry.value is Map
                                          ? Map<String, dynamic>.from(
                                              entry.value as Map)
                                          : {};

                                  return ExpansionTile(
                                    title: Text('Project Name: ${entry.key}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    children:
                                        projectData.entries.map((dataEntry) {
                                      String label = labels[dataEntry.key] ??
                                          dataEntry.key;
                                      if (dataEntry.key == 'image') {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                              dataEntry.value.toString()),
                                        );
                                      } else {
                                        return ListTile(
                                          title: Text('$label:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Text('${dataEntry.value}'),
                                        );
                                      }
                                    }).toList(),
                                  );
                                }).toList(),
                              )
                            : Container());
                  },
                ))
              ],
            );
          }
        },
      ),
    );
  }
}
