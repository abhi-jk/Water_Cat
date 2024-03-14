import 'package:flutter/material.dart';

class CitizenPortalPage extends StatefulWidget {
  CitizenPortalPage({Key? key}) : super(key: key);

  @override
  _CitizenPortalPageState createState() => _CitizenPortalPageState();
}

class _CitizenPortalPageState extends State<CitizenPortalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citizens Portal'),
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
                        fontSize: 25, fontWeight: FontWeight.bold),
                    minimumSize: Size(double.infinity, 150)),
                onPressed: () {
                  Navigator.pushNamed(context, '/project');
                },
                child: const Text(
                  'Start New Project',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  minimumSize: Size(double.infinity, 150),
                ),
                onPressed: () {},
                child: const Text(
                  'Citizens Observation Portal',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
