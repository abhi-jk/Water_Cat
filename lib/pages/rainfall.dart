import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Rainfall extends StatefulWidget {
  const Rainfall({Key? key}) : super(key: key);

  @override
  _RainfallState createState() => _RainfallState();
}

class _RainfallState extends State<Rainfall> {
  final _formKey = GlobalKey<FormState>();
  final _rainController = TextEditingController();

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
