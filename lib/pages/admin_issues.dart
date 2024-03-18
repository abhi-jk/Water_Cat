import 'package:cwrdm/database/service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class IssuesPage extends StatelessWidget {
  // Dummy list of issues, replace with your actual data source

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issues'),
      ),
      body: FutureBuilder<List<Map<String,String>>>(
          future: getAdminIssues(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Issues Yet'))
                  : ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          margin: const EdgeInsets.all(10),
                          child: ExpansionTile(
                            title: Text('Description: ${snapshot.data![index]['description']!}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                              ],
                            ),
                            children: [
                              ListTile(
                                title: Text('Location: ${snapshot.data![index]['location']!}'),
                              ),
                              ListTile(
                                title: Text('Date: ${snapshot.data![index]['date']!}'),
                              ),
                              ListTile(
                                title: Text('Submitted By: ${snapshot.data![index]['auther']!}'),
                              ),
                              Image.network(snapshot.data![index]['image']!)
                            ],
                          ),
                        );
                      },
                    );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
