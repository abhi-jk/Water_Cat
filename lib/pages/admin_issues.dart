import 'package:cwrdm/database/service.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class IssuesPage extends StatelessWidget {
  // Dummy list of issues, replace with your actual data source

  Future<List<int>> generatePdf(Map<String, dynamic> projectData) async {
    final pdf = pw.Document();

    final imageUrl = projectData['image'] as String;
    final response = await http.get(Uri.parse(imageUrl));
    final imageTempDir = await getTemporaryDirectory();
    final imageTempPath = imageTempDir.path + '/tempImage.jpg';
    File imageTempFile = File(imageTempPath);
    await imageTempFile.writeAsBytes(response.bodyBytes);

    final image = pw.MemoryImage(
      await imageTempFile.readAsBytes(),
    );

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
                    'Issue Report',
                    style: pw.TextStyle(
                        fontSize: 30, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Center(
                  child: pw.Image(image, width: 250, height: 250),
                ),
                pw.SizedBox(height: 20),
                ...projectData.entries.map((entry) {
                  if (entry.key == 'image')
                    return pw.SizedBox
                        .shrink(); // Don't display the image URL in the text
                  return pw.Padding(
                    padding: pw.EdgeInsets.only(bottom: 5.0),
                    child: pw.Text(
                      '${entry.key}: ${entry.value}',
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issues'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
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
                            title: Text(
                              'Issue: ${snapshot.data![index]['description']!}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                            children: [
                              ListTile(
                                title: Text(
                                    'Location: ${snapshot.data![index]['location']!}'),
                              ),
                              ListTile(
                                title: Text(
                                    'Date: ${snapshot.data![index]['date']!}'),
                              ),
                              ListTile(
                                title: Text(
                                    'Submitted By: ${snapshot.data![index]['auther']!}'),
                              ),
                              Image.network(snapshot.data![index]['image']!),
                              ElevatedButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), // Dialog shape
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
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

                                  final pdf = await generatePdf(snapshot.data![
                                      index]); // Generate the PDF for the specific issue
                                  final path = await getDownloadsDirectory();
                                  final file = File(
                                      '${path!.path}/${snapshot.data![index]['description']}.pdf');
                                  await file.writeAsBytes(pdf);

                                  if (await file.exists()) {
                                    OpenFile.open(file.path);
                                    Navigator.pop(context);
                                  } else {
                                    print('File does not exist');
                                  }
                                },
                                child: const Text('Download PDF'),
                              ),
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
