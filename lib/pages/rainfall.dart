import 'package:cwrdm/database/service.dart';
import 'package:flutter/material.dart';

class Rainfall extends StatefulWidget {
  const Rainfall({Key? key}) : super(key: key);

  @override
  _RainfallState createState() => _RainfallState();
}

class _RainfallState extends State<Rainfall> {
  final _formKey = GlobalKey<FormState>();
  final _rainController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Report Rainfall',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _rainController,
                        decoration: InputDecoration(
                          labelText: 'Rainfall Reading (mm)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the rainfall';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width * 0.6, 50)),
                        ),
                        onPressed: () async {
                          _formKey.currentState!.validate();
                          await reportRainfall(
                              description: _rainController.text,
                              loc: _locationController.text,
                              context: context);
                          //clear the fields
                          _rainController.clear();
                          _locationController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Submit'),
                      ),
                      //const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
