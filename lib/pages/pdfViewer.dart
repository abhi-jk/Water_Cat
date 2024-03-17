import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  final String path;

  PdfViewerPage({required this.path});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  int currentPage = 0;
  int totalPages = 0;
  PDFViewController? pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PDFView(
              filePath: widget.path,
              onViewCreated: (PDFViewController pdfViewController) {
                setState(() {
                  this.pdfViewController = pdfViewController;
                });
              },
              onRender: (pages) {
                setState(() {
                  totalPages = pages!;
                });
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  currentPage = (page ?? currentPage) + 1;
                });
              },
            ),
          ),
          Text(
            'Page: $currentPage/$totalPages',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}
