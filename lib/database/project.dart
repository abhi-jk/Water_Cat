import 'dart:io';

import 'package:cwrdm/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addNewProject(
    {required String projectName,
    required String sampleDetails,
    required String location,
    required String observation,
    required String pH,
    required String alkaline,
    required String hardness,
    required String chloride,
    required String tds,
    required String iron,
    required String ammonia,
    required String nitrate,
    required String phosphate,
    required String resCl,
    required String waterlvl,
    required String remark,
    required File file,
    required BuildContext context}) async {
  print("user : $currentUser");
  print("file : ${file.toString()}");
  //show loading dialog
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  final ref = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('projects');
  //final cloud = CloudF
  //check if the project name already exists
 await ref.child(projectName).once().then((DatabaseEvent snapshot) async {
    if (snapshot.snapshot.value != null) {
      //show snackbar
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Project name already exists'),
        ),
      );
    } else {
      //upload image to firebase cloud
      final firestoreRef = FirebaseStorage.instance
          .ref('projects/${currentUser!.uid}/$projectName/image.jpg');

      final uploadTask = await firestoreRef.putFile(
        file,
      );

      if (uploadTask.state == TaskState.success) {
        final url = await firestoreRef.getDownloadURL();
       await ref.child(projectName).set({
          'projectName': projectName,
          'sampleDetails': sampleDetails,
          'location': location,
          'observation': observation,
          'pH': pH,
          'alkaline': alkaline,
          'hardness': hardness,
          'chloride': chloride,
          'tds': tds,
          'iron': iron,
          'ammonia': ammonia,
          'nitrate': nitrate,
          'phosphate': phosphate,
          'resCl': resCl,
          'waterlvl': waterlvl,
          'remark': remark,
          'image': url,
        }).whenComplete(() {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Project added successfully'),
            ),
          );
          // Navigator.pushReplacementNamed(context, '/home');
        }).onError<FirebaseException>((error, stackTrace) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.code),
            ),
          );
        });
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error uploading image'),
          ),
        );
      }
    }
  });
}
