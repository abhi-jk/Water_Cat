import 'dart:io';

import 'package:cwrdm/database/project.dart';
import 'package:cwrdm/pages/resultPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class ProjectsSubmitted extends StatefulWidget {


  @override
  _ProjectsSubmittedState createState() => _ProjectsSubmittedState();
}

class _ProjectsSubmittedState extends State<ProjectsSubmitted> { 
   var data;
  void init() async {
    data = await rootBundle.load("assets/fonts/Montserrat-Regular.ttf");
  }
  @override
  void initState() {
    init();
    super.initState();
  }
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
              .ref()
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
                            trailing: //button to downlaod pdf
                                (projectData['isApproved'] == 'true')
                                    ? IconButton(
                                        icon: Icon(Icons.download),
                                        onPressed: () async {
                                          Project project = Project(
                                            projectName:
                                                projects.keys.elementAt(index),
                                            isApproved:
                                                projectData['isApproved'],
                                            alkaline: projectData['alkaline'],
                                            ammonia: projectData['ammonia'],
                                            image: projectData['image'],
                                            auther: projectData['auther'],
                                            chloride: projectData['chloride'],
                                            hardness: projectData['hardness'],
                                            iron: projectData['iron'],
                                            location: projectData['location'],
                                            nitrate: projectData['nitrate'],
                                            pH: projectData['pH'],
                                            phosphate: projectData['phosphate'],
                                            observation:
                                                projectData['observation'],
                                            remark: projectData['remark'],
                                            resCl: projectData['resCl'],
                                            tds: projectData['tds'],
                                            sampleDetails:
                                                projectData['sampleDetails'],
                                            waterlvl: projectData['waterlvl'],
                                          );
                                          final pdf = pw.Document();

                                          pdf.addPage(pw.Page(
                                              pageFormat: PdfPageFormat.a4,
                                              build: (pw.Context context) {
                                                return result(project);
                                              }));
                                          final path =
                                              await getDownloadsDirectory();
                                          final file = File(
                                              '${path!.path}/${projects.keys.elementAt(index)}.pdf');
                                          await file.writeAsBytes(
                                              await pdf.save()); // Page

//                                           // create instance of ExportDelegate
//                                           final ExportDelegate exportDelegate =
//                                               ExportDelegate();

// // export the frame to a PDF Document
//                                           final pdf = await exportDelegate
//                                               .exportToPdfDocument(

//                                                   'someFrameId');
//                                           pdf.save();

// // export the frame to a PDF Page
//                                           final page = await exportDelegate
//                                               .exportToPdfPage('someFrameId');

// // export the frame to a PDF Widget
//                                           final widget = await exportDelegate
//                                               .exportToPdfWidget('someFrameId');
                                        })
                                    : null,
                            subtitle: Text(
                                'status: ${projectData['isApproved'] == 'true' ? 'Approved' : 'Pending'}'),
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
                              } else if (dataEntry.key == 'isApproved') {
                                return ListTile(
                                  title: Text('${dataEntry.key}:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                      '${dataEntry.value == 'true' ? 'Approved' : 'Pending'}'),
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

  pw.Widget result(Project project) {
    var myFont = pw.Font.ttf(data);

    return pw.ListView(children: <pw.Widget>[
      pw.Container(
        child: pw.Text('pH',
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, font: myFont)),
      ),
      pw.Container(
        child: pw.Text('User: ${project.pH}, Acceptable: (6.5-8.5)',
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, font: myFont)),
      ),
    ]);
  }
}
