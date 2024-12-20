import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cwrdm/database/project.dart';
import 'package:cwrdm/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
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

  Future<List<int>> generatePdf(Map<String, dynamic> projectData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(10.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'Water Quality Test Report',
                    style: pw.TextStyle(
                        fontSize: 30, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Date of Analysis',
                      'Particular of the Sample',
                      'Location',
                      'Sample ID',
                      'Sample Description'
                    ],
                    [
                      projectData['Date of Analysis'],
                      projectData['Particular of Sample'],
                      projectData['Location'],
                      projectData['Sample ID'],
                      projectData['Sample Description'],
                    ]
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Sl No.',
                      'Parameter',
                      'Unit',
                      'Result',
                      'Acceptable Limit'
                    ],
                    [
                      '1',
                      'pH Value',
                      '---',
                      projectData['pH'].toString(),
                      '6.5-8.5'
                    ],
                    [
                      '2',
                      'Total Dissolved Solids',
                      'mg/l',
                      projectData['TDS'].toString(),
                      '500'
                    ],
                    [
                      '3',
                      'Total Alkalinity',
                      'mg/l',
                      projectData['Alkaline'].toString(),
                      '200'
                    ],
                    [
                      '4',
                      'Total Hardness',
                      'mg/l',
                      projectData['Hardness'].toString(),
                      '200'
                    ],
                    [
                      '5',
                      'Chloride',
                      'mg/l',
                      projectData['Chloride'].toString(),
                      '250'
                    ],
                    ['6', 'Iron', 'mg/l', projectData['Iron'].toString(), '1'],
                    [
                      '7',
                      'Total Coliforms',
                      '---',
                      projectData['Coliforms'].toString(),
                      'Shall not be present'
                    ],
                  ],
                ),
                pw.Table.fromTextArray(
                  context: context,
                  cellAlignments: {0: pw.Alignment.centerLeft},
                  data: <List<String>>[
                    ['Remarks: ${projectData['Remark']}'],
                  ],
                ),
                pw.SizedBox(height: 60),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text('Authorised Signature'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  Map<String, String> labels = {
    'isApproved': 'Approval Status',
    'date': 'Date of Analysis',
    'sampleid': 'Sample ID',
    'particular': 'Particular of Sample',
    'sampleDesc': 'Sample Description',
    'projectName': 'Project Name',
    'location': 'Location',
    'pH': 'pH',
    'alkaline': 'Alkaline',
    'hardness': 'Hardness',
    'chloride': 'Chloride',
    'tds': 'TDS',
    'iron': 'Iron',
    'coliforms': 'Coliforms',
    'remark': 'Remark',
    'author': 'Author',
  };

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
                      'Projects Submitted: ${projects.length}',
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
                                          final projectData = {
                                            'Auther': currentUser!.displayName!,
                                            'Project Name':
                                                projects.keys.elementAt(index),
                                            'Approval Status': 'Approved',
                                            'Alkaline': projects.values
                                                .elementAt(index)['alkaline'],
                                            'Chloride': projects.values
                                                .elementAt(index)['chloride'],
                                            'Hardness': projects.values
                                                .elementAt(index)['hardness'],
                                            'Iron': projects.values
                                                .elementAt(index)['iron'],
                                            'Location': projects.values
                                                .elementAt(index)['location'],
                                            'pH': projects.values
                                                .elementAt(index)['pH'],
                                            'Remark': projects.values
                                                .elementAt(index)['remark'],
                                            'TDS': projects.values
                                                .elementAt(index)['tds'],
                                            'Sample Description': projects
                                                .values
                                                .elementAt(index)['sampleDesc'],
                                            'Particular of Sample': projects
                                                .values
                                                .elementAt(index)['particular'],
                                            'Sample ID': projects.values
                                                .elementAt(index)['sampleid'],
                                            'Date of Analysis': projects.values
                                                .elementAt(index)['date'],
                                            'Coliforms': projects.values
                                                .elementAt(index)['coliforms'],
                                          };

                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Dialog shape
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(15.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CircularProgressIndicator(),
                                                      SizedBox(
                                                          width:
                                                              25), // Add some space between the CircularProgressIndicator and the text
                                                      Text(
                                                        "Loading",
                                                        style: TextStyle(
                                                          fontSize:
                                                              18, // Increase the font size
                                                          fontWeight: FontWeight
                                                              .bold, // Make the text bold
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                          final pdf = await generatePdf(
                                              projectData); // Generate the PDF
                                          final path =
                                              await getDownloadsDirectory();
                                          final file = File(
                                              '${path!.path}/${projects.keys.elementAt(index)}.pdf');
                                          await file.writeAsBytes(pdf);

                                          if (await file.exists()) {
                                            OpenFile.open(file.path);
                                            Navigator.pop(context);
                                          } else {
                                            print('File does not exist');
                                          }
                                        },
                                      )
                                    : null,
                            subtitle: Text(
                                'Approval Status: ${projectData['isApproved'] == 'true' ? 'Approved' : 'Pending'}'),
                            title: Text(
                                'Project Name: ${projects.keys.elementAt(index)}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            children: projectData.entries.map((dataEntry) {
                              String label =
                                  labels[dataEntry.key] ?? dataEntry.key;
                              if (dataEntry.key == 'image') {
                                if (dataEntry.value == null || dataEntry.value == '') {
                                  return ListTile(
                                    title: Text('$label:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text('No image uploaded'),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Image.network(dataEntry.value.toString()),
                                );
                              } else if (dataEntry.key == 'isApproved') {
                                return ListTile(
                                  title: Text('$label:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                      '${dataEntry.value == 'true' ? 'Approved' : 'Pending'}'),
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
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: myFont)),
      ),
      pw.Container(
        child: pw.Text('User: ${project.pH}, Acceptable: (6.5-8.5)',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: myFont)),
      ),
    ]);
  }
}
