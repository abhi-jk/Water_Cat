import 'package:cwrdm/database/project.dart';
import 'package:flutter/material.dart';

class SubmittedProjectsPage extends StatefulWidget {
  @override
  _SubmittedProjectsPageState createState() => _SubmittedProjectsPageState();
}

class _SubmittedProjectsPageState extends State<SubmittedProjectsPage> {
  // Dummy list of projects, replace with your actual data source

  //future builder on fn getUnapprovedProjects
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Submitted Projects'),
        ),
        body: FutureBuilder<List<Project>>(
            future: getUnapprovedProjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return snapshot.data!.isEmpty
                    ? const Center(child: Text('No Projects Yet'))
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
                              title: Text(snapshot.data![index].projectName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Location: ${snapshot.data![index].location}'),
                                  Text(
                                      'Sample Details: ${snapshot.data![index].sampleid}'),
                                  Text(
                                      'Observation: ${snapshot.data![index].observation}'),
                                ],
                              ),
                              children: [
                                ListTile(
                                  title:
                                      Text('pH: ${snapshot.data![index].pH}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Alkaline: ${snapshot.data![index].alkaline}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Hardness: ${snapshot.data![index].hardness}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Chloride: ${snapshot.data![index].chloride}'),
                                ),
                                ListTile(
                                  title:
                                      Text('TDS: ${snapshot.data![index].tds}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Iron: ${snapshot.data![index].iron}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Remark: ${snapshot.data![index].remark}'),
                                ),
                                Image.network(snapshot.data![index].image),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Approve Project'),
                                          content: const Text(
                                              'Are you sure you want to approve this project?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  approveProject(
                                                      snapshot
                                                          .data![index].auther,
                                                      snapshot.data![index]
                                                          .projectName);
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Project Approved'),
                                                    ),
                                                  );
                                                  setState(() {
                                                    snapshot.data!
                                                        .removeAt(index);
                                                  });
                                                },
                                                child: const Text('Approve')),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    //show snack send to admin for approval
                                  },
                                  child: Text('Approve'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                        });
              }
            }));
  }
}
