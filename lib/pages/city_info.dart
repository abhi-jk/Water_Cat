import 'package:flutter/material.dart';

class CityInfoPage extends StatefulWidget {
  CityInfoPage({Key? key}) : super(key: key);

  @override
  _CityInfoPageState createState() => _CityInfoPageState();
}

class _CityInfoPageState extends State<CityInfoPage> {
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
                        fontSize: 25, fontWeight: FontWeight.bold),
                    minimumSize: Size(double.infinity, 70)),
                onPressed: () {},
                child: const Text('Demographic details'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () {},
                child: const Text('Water Resources(Ponds,River,Canal)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () {},
                child: const Text('Ground Water Level'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () {},
                child: const Text('Water Quality Data'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () {},
                child: const Text('Rainfall and Temperature'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () {},
                child: const Text('Flood Prone Areas'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  minimumSize: Size(double.infinity, 70),
                ),
                onPressed: () {},
                child: const Text('Water Stress Areas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
