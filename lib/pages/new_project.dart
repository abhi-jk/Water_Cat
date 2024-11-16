import 'dart:io';
import 'package:cwrdm/database/project.dart';
import 'package:cwrdm/global.dart';
import 'package:cwrdm/pages/resultPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewProjectPage extends StatefulWidget {
  const NewProjectPage({Key? key}) : super(key: key);

  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sampleidController = TextEditingController();
  final _locationController = TextEditingController();
  final _pHController = TextEditingController();
  final _alkalineController = TextEditingController();
  final _hardnessController = TextEditingController();
  final _chlorideController = TextEditingController();
  final _tdsController = TextEditingController();
  final _ironController = TextEditingController();
  final _descController = TextEditingController();
  final _particularController = TextEditingController();
  final _dateController = TextEditingController();
  final _coliformsController = TextEditingController();
  final _remarkController = TextEditingController();
  String filename = '';
  XFile? imagefile;

  Future<void> _submit(
    BuildContext context,
  ) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String sampleId = _sampleidController.text;
      String location = _locationController.text;
      String pH = _pHController.text;
      String alkaline = _alkalineController.text;
      String hardness = _hardnessController.text;
      String chloride = _chlorideController.text;
      String tds = _tdsController.text;
      String iron = _ironController.text;
      String remark = _remarkController.text;
      String sampleDesc = _descController.text;
      String particular = _particularController.text;
      //select only date from date time

      String date = _dateController.text.split(' ')[0];
      String coliforms = _coliformsController.text;

      await addNewProject(
        projectName: name,
        sampleid: sampleId,
        sampleDesc: sampleDesc,
        particular: particular,
        date: date,
        location: location,
        pH: pH,
        alkaline: alkaline,
        hardness: hardness,
        chloride: chloride,
        tds: tds,
        iron: iron,
        coliforms: coliforms,
        remark: remark,
        context: context,
        file: imagefile!=null?File(imagefile!.path):null,
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
                        controller: _sampleidController,
                        decoration: InputDecoration(
                          labelText: 'Sample ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the id';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _descController,
                        decoration: InputDecoration(
                          labelText: 'Sample Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the descrtiption';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _particularController,
                        decoration: InputDecoration(
                          labelText: 'Particular of the Sample',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the particular of the sample';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      //select date from date picker
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Date of Collection',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            _dateController.text =
                                picked.toString().split(' ')[0];
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the date';
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
                            return 'Please enter the PH or 0 if not available';
                          } else if (double.parse(value) < 0) {
                            return 'PH cannot be negative';
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
                            return 'Please enter the alkalinity or 0 if not available';
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
                            return 'Please enter the hardness or 0 if not available';
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
                            return 'Please enter the chloride or 0 if not available';
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
                            return 'Please enter the TDS or 0 if not available';
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
                            return 'Please enter the iron or 0 if not available';
                          } else if (double.parse(value) < 0) {
                            return 'Iron cannot be negative';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _coliformsController,
                        decoration: InputDecoration(
                          labelText: 'Coliforms',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the coliforms';
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
                          if (_formKey.currentState!.validate()) {
                            await _submit(context).whenComplete(() {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultsPage(
                                          project: Project(
                                            projectName: _nameController.text,
                                            sampleid: _sampleidController.text,
                                            sampleDesc: _descController.text,
                                            particular:
                                                _particularController.text,
                                            date: _dateController.text,
                                            location: _locationController.text,
                                            pH: _pHController.text,
                                            alkaline: _alkalineController.text,
                                            hardness: _hardnessController.text,
                                            chloride: _chlorideController.text,
                                            tds: _tdsController.text,
                                            iron: _ironController.text,
                                            coliforms:
                                                _coliformsController.text,
                                            remark: _remarkController.text,
                                            image: imagefile?.path ?? '',
                                            auther: currentUser!.uid,
                                            isApproved: 'false',
                                          ),
                                        )),
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
