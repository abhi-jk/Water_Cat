import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  String filename = '';
  XFile? imagefile;

  // Future<void> _submit(
  //   BuildContext context,
  // ) async {
  //   if (_formKey.currentState!.validate()) {
  //     String name = _nameController.text;
  //     String sampleDetails = _sampleDetailsController.text;
  //     String location = _locationController.text;
  //     String observation = _observationController.text;
  //     String pH = _pHController.text;
  //     String alkaline = _alkalineController.text;
  //     String hardness = _hardnessController.text;
  //     String chloride = _chlorideController.text;
  //     String tds = _tdsController.text;
  //     String iron = _ironController.text;
  //     String ammonia = _ammoniaController.text;
  //     String nitrate = _nitrateController.text;
  //     String phosphate = _phosphateController.text;
  //     String resCl = _resClController.text;
  //     String waterlvl = _waterlvlController.text;
  //     String remark = _remarkController.text;

  //     await addNewProject(
  //       projectName: name,
  //       sampleDetails: sampleDetails,
  //       location: location,
  //       observation: observation,
  //       pH: pH,
  //       alkaline: alkaline,
  //       hardness: hardness,
  //       chloride: chloride,
  //       tds: tds,
  //       iron: iron,
  //       ammonia: ammonia,
  //       nitrate: nitrate,
  //       phosphate: phosphate,
  //       resCl: resCl,
  //       waterlvl: waterlvl,
  //       remark: remark,
  //       context: context,
  //       file: File(imagefile!.path),
  //     );
  //     // print(imagefile!.path);
  //   }
  // }

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
                      const Text('Report an Issue',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _descController,
                        decoration: InputDecoration(
                          labelText: 'Description of the issue',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the description of the issue';
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
                        onPressed: () async {},
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
