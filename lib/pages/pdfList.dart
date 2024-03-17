import 'package:cwrdm/pages/pdfViewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfListScreen extends StatelessWidget {
  final List<String> pdfPaths;

  PdfListScreen({required this.pdfPaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Water Qulaity Data')),
      body: ListView.builder(
        itemCount: pdfPaths.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'PDF ${index + 1}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerPage(
                    path: pdfPaths[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
