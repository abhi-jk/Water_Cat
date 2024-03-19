import 'package:cwrdm/pages/pdfList.dart';
import 'package:cwrdm/pages/pdfViewer.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class CityInfoPage extends StatefulWidget {
  CityInfoPage({Key? key}) : super(key: key);

  @override
  _CityInfoPageState createState() => _CityInfoPageState();
}

class _CityInfoPageState extends State<CityInfoPage> {
  Future<String> copyAsset(String asset) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final fileName =
        asset.split('/').last; // Get the file name from the asset path
    final file = await new File('$tempPath/$fileName').create();
    final data = await rootBundle.load(asset);
    await file.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Informations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    minimumSize: Size(double.infinity, 70)),
                onPressed: () async {
                  final pdfPath = await copyAsset('assets/DEMOGRAPHY_.pdf');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(
                        path: pdfPath,
                      ),
                    ),
                  );
                },
                child: const Text('Demographic details'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () async {
                  final pdfPath = await copyAsset('assets/POND_ATLAS.pdf');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(
                        path: pdfPath,
                      ),
                    ),
                  );
                },
                child: const Text('Water Resources(Ponds,River,Canal)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () async {
                  final pdfPath =
                      await copyAsset('assets/Water_Quality_Kozhikode.pdf');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(
                        path: pdfPath,
                      ),
                    ),
                  );
                },
                child: const Text('Ground Water Information'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () async {
                  final pdfPaths = [
                    await copyAsset('assets/Water_quality_Canoli_Canal.pdf'),
                    await copyAsset('assets/Water_Quality_Kozhikode.pdf'),
                  ];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfListScreen(pdfPaths: pdfPaths),
                    ),
                  );
                },
                child: const Text('Water Quality Information'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () async {
                  final pdfPath = await copyAsset('assets/CITY_PROFILE.pdf');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(
                        path: pdfPath,
                      ),
                    ),
                  );
                },
                child: const Text('Rainfall and Temperature'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () {
                  //snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coming Soon'),
                    ),
                  );
                },
                child: const Text('Flood Prone Areas'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () {
                  //snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coming Soon'),
                    ),
                  );
                },
                child: const Text('Water Stress Areas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
