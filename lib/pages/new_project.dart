import 'dart:io';

import 'package:cwrdm/Authetication/SignInPage.dart';
import 'package:cwrdm/database/project.dart';
import 'package:cwrdm/pages/resultPage.dart';
import 'package:flutter/material.dart';
import '../database/auth.dart';
import 'package:image_picker/image_picker.dart';

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
  String filename = '';
  XFile? imagefile;

  Future<void> _submit(
    BuildContext context,
  ) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String sampleDetails = _sampleDetailsController.text;
      String location = _locationController.text;
      String observation = _observationController.text;
      String pH = _pHController.text;
      String alkaline = _alkalineController.text;
      String hardness = _hardnessController.text;
      String chloride = _chlorideController.text;
      String tds = _tdsController.text;
      String iron = _ironController.text;
      String ammonia = _ammoniaController.text;
      String nitrate = _nitrateController.text;
      String phosphate = _phosphateController.text;
      String resCl = _resClController.text;
      String waterlvl = _waterlvlController.text;
      String remark = _remarkController.text;

      await addNewProject(
        projectName: name,
        sampleDetails: sampleDetails,
        location: location,
        observation: observation,
        pH: pH,
        alkaline: alkaline,
        hardness: hardness,
        chloride: chloride,
        tds: tds,
        iron: iron,
        ammonia: ammonia,
        nitrate: nitrate,
        phosphate: phosphate,
        resCl: resCl,
        waterlvl: waterlvl,
        remark: remark,
        context: context,
        file: File(imagefile!.path),
      );
      // print(imagefile!.path);
    }
  }

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
                      const Text('New Project',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                            return 'Please enter your location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _pHController,
                        keyboardType: TextInputType.number,
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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

                      // add button to upload image
                      TextButton(
                          onPressed: () {},
                          child: ListTile(
                            leading: const Icon(Icons.upload_file),
                            title: filename == ''
                                ? const Text('Upload Image')
                                : Text(filename),
                            onTap: () async {
                              final ImagePicker _picker = ImagePicker();
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  filename = image.path.split('/').last;
                                  imagefile = image;
                                });
                              }
                            },
                          )),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(250, 50)),
                        ),
                        onPressed: () async {
                          if (filename == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please upload an image'),
                              ),
                            );
                          }
                          if (_formKey.currentState!.validate() &&
                              filename != '') {
                            await _submit(context).whenComplete(() {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultsPage(
                                    pH: _pHController.text == ''
                                        ? 0
                                        : double.parse(_pHController.text),
                                    alkaline: _alkalineController.text == ''
                                        ? 0
                                        : double.parse(
                                            _alkalineController.text),
                                    hardness: _hardnessController.text == ''
                                        ? 0
                                        : double.parse(
                                            _hardnessController.text),
                                    chloride: _chlorideController.text == ''
                                        ? 0
                                        : double.parse(
                                            _chlorideController.text),
                                    tds: _tdsController.text == ''
                                        ? 0
                                        : double.parse(_tdsController.text),
                                    iron: _ironController.text == ''
                                        ? 0
                                        : double.parse(_ironController.text),
                                    ammonia: _ammoniaController.text == ''
                                        ? 0
                                        : double.parse(_ammoniaController.text),
                                    nitrate: _nitrateController.text == ''
                                        ? 0
                                        : double.parse(_nitrateController.text),
                                    resCl: _resClController.text == ''
                                        ? 0
                                        : double.parse(_resClController.text),
                                  ),
                                ),
                              );
                            });
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
