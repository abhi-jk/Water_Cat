import 'package:flutter/material.dart';

class CitizenObservationPortal extends StatefulWidget {
  CitizenObservationPortal({Key? key}) : super(key: key);

  @override
  _CitizenObservationPortalState createState() =>
      _CitizenObservationPortalState();
}

class _CitizenObservationPortalState extends State<CitizenObservationPortal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citizens Observation Portal'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
                      minimumSize: Size(double.infinity, 90)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/issues');
                  },
                  child: const Text(
                    'Report an Issue',
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    minimumSize: Size(double.infinity, 90),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/diversity');
                  },
                  child: const Text(
                    'Report Biodiversity',
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    minimumSize: Size(double.infinity, 90),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/floodlevel');
                  },
                  child: const Text(
                    'Flood Level',
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    minimumSize: Size(double.infinity, 90),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/groundwaterlevel');
                  },
                  child: const Text(
                    'Ground Water Level',
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    minimumSize: Size(double.infinity, 90),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/rainfall');
                  },
                  child: const Text(
                    'Rainfall',
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
      ),
    );
  }
}
