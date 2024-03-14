import 'package:cwrdm/Authetication/SignInPage.dart';
import 'package:flutter/material.dart';
import '../database/auth.dart';

class NewProjectPage extends StatefulWidget {
  const NewProjectPage({Key? key}) : super(key: key);

  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sampleDetailsController = TextEditingController();
  final _locationController = TextEditingController();
  final _observationController = TextEditingController();
  final _pHController = TextEditingController();
  final _alkalineController = TextEditingController();
  final _hardnessController = TextEditingController();
  final _chlorideController = TextEditingController();
  final _tdsController = TextEditingController();
  final _ironController = TextEditingController();
  final _ammoniaController = TextEditingController();
  final _nitrateController = TextEditingController();
  final _phosphateController = TextEditingController();
  final _resClController = TextEditingController();
  final _waterlvlController = TextEditingController();
  final _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      const Text('New Project',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name of the project',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _sampleDetailsController,
                        decoration: InputDecoration(
                          labelText: 'Sample details',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the details';
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
                            return 'Please enter your location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _observationController,
                        decoration: InputDecoration(
                          labelText:
                              'General Observation (colour,tubidity,odour)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your observation';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _pHController,
                        decoration: InputDecoration(
                          labelText: 'PH',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the PH';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _alkalineController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Alkalinity(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the alkalinity';
                          } else if (double.parse(value) < 0) {
                            return 'Alkalinity cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _hardnessController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Hardness(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the hardness';
                          } else if (double.parse(value) < 0) {
                            return 'hardness cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _chlorideController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Chloride(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the chloride';
                          } else if (double.parse(value) < 0) {
                            return 'Chloride cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _tdsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'TDS(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the TDS';
                          } else if (double.parse(value) < 0) {
                            return 'TDS cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _ironController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Iron(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the iron';
                          } else if (double.parse(value) < 0) {
                            return 'Iron cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _ammoniaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Ammonia(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the ammonia';
                          } else if (double.parse(value) < 0) {
                            return 'Ammonia cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _nitrateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nitrate(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the nitrate';
                          } else if (double.parse(value) < 0) {
                            return 'Nitrate cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _phosphateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phosphate(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the phosphate';
                          } else if (double.parse(value) < 0) {
                            return 'Phosphate cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _resClController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Residual Chlorine(mg/L)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the residual chlorine';
                          } else if (double.parse(value) < 0) {
                            return 'Residual Chlorine cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _waterlvlController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Water Level(m)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the water level';
                          } else if (double.parse(value) < 0) {
                            return 'Water level cannot be negative';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _remarkController,
                        decoration: InputDecoration(
                          labelText: 'Remarks',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your remarks';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(250, 50)),
                        ),
                        onPressed: () {
                          _formKey.currentState!.validate();
                        },
                        child: const Text('Submit'),
                      ),
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