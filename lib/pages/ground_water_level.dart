import 'package:cwrdm/database/service.dart';
import 'package:flutter/material.dart';

class GroundWater extends StatefulWidget {
  const GroundWater({Key? key}) : super(key: key);

  @override
  _GroundWaterState createState() => _GroundWaterState();
}

class _GroundWaterState extends State<GroundWater> {
  final _formKey = GlobalKey<FormState>();
  final _grndController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Report Ground Water Level',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _grndController,
                        decoration: InputDecoration(
                          labelText: 'Ground Water Level(m)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the ground water level';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
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
                          minimumSize:
                              MaterialStateProperty.all(const Size(250, 50)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // await _submit(context);
                            await reportGroundWaterLevel(
                                description: _grndController.text,
                                loc: _locationController.text,
                                context: context);
                            //clear the fields
                            _grndController.clear();
                            _locationController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(height: 20),
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
