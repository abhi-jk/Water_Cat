import 'dart:io';

import 'package:cwrdm/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String projectName;
  final String sampleid;
  final String sampleDesc;
  final String particular;
  final String date;
  final String location;
  final String pH;
  final String alkaline;
  final String hardness;
  final String chloride;
  final String tds;
  final String iron;
  final String coliforms;
  final String remark;
  final String image;
  final String auther;
  final String isApproved;

  Project({
    required this.projectName,
    required this.sampleid,
    required this.sampleDesc,
    required this.particular,
    required this.date,
    required this.location,
    required this.pH,
    required this.alkaline,
    required this.hardness,
    required this.chloride,
    required this.tds,
    required this.iron,
    required this.coliforms,
    required this.remark,
    required this.image,
    required this.auther,
    required this.isApproved,
  });
}

Future<void> addNewProject(
    {required String projectName,
    required String sampleid,
    required String sampleDesc,
    required String particular,
    required String date,
    required String location,
    required String pH,
    required String alkaline,
    required String hardness,
    required String chloride,
    required String tds,
    required String iron,
    required String coliforms,
    required String remark,
    File? file,
    required BuildContext context}) async {
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
      String? url;
      //upload image to firebase cloud
      if (file != null)
      {final firestoreRef = FirebaseStorage.instance
          .ref('projects/${currentUser!.uid}/$projectName/image.jpg');

      final uploadTask = await firestoreRef.putFile(
        file,
      );
      if (uploadTask.state == TaskState.success) {
         url= await firestoreRef.getDownloadURL();}
      
       else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error uploading image'),
          ),
        );
      }
      }
        await ref.child(projectName).set({
          'projectName': projectName,
          'auther': currentUser!.uid,
          'isApproved': 'false', //default value
          'sampleid': sampleid,
          'sampleDesc': sampleDesc,
          'particular': particular,
          'date': date,
          'location': location,
          'pH': pH,
          'alkaline': alkaline,
          'hardness': hardness,
          'chloride': chloride,
          'tds': tds,
          'iron': iron,
          'coliforms': coliforms,
          'remark': remark,
          'image': url??'',
        }).whenComplete(() {
          Navigator.pop(context);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Project send for approval'),
          //   ),
          // );
          // Navigator.pushReplacementNamed(context, '/home');
        }).onError<FirebaseException>((error, stackTrace) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.code),
            ),
          );
        });
      }
    }
  );
}

//get unapproved projects
Future<List<Project>> getUnapprovedProjects() async {
  final ref = FirebaseDatabase.instance.ref().child('users');
  List<Project> projectsList = [];
  projectsList = await ref.once().then((DatabaseEvent snapshot) async {
    final data = snapshot.snapshot.children;
    List<Project> projects = [];
    //print(data);
    data.forEach((element) async {
      final projectsData = element.child('projects');
      projectsData.children.forEach((element) async {
        if (element.child('isApproved').value.toString() == 'false') {
          projects.add(Project(
            auther: element.child('auther').value.toString(),
            projectName: element.child('projectName').value.toString(),
            sampleid: element.child('sampleDetails').value.toString(),
            sampleDesc: element.child('sampleDesc').value.toString(),
            particular: element.child('particular').value.toString(),
            date: element.child('date').value.toString(),
            location: element.child('location').value.toString(),
            pH: element.child('pH').value.toString(),
            alkaline: element.child('alkaline').value.toString(),
            hardness: element.child('hardness').value.toString(),
            chloride: element.child('chloride').value.toString(),
            tds: element.child('tds').value.toString(),
            iron: element.child('iron').value.toString(),
            coliforms: element.child('coliforms').value.toString(),
            remark: element.child('remark').value.toString(),
            image: element.child('image').value.toString(),
            isApproved: element.child('isApproved').value.toString(),
          ));
        }
      });
    });

    return projects;
  });
  return projectsList;
}

Future approveProject(String userId, String projectName) async {
  final ref = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(userId)
      .child('projects')
      .child(projectName);
  await ref.update({'isApproved': 'true'}).then((value) {
    print('Project approved');
  }).onError<FirebaseException>((error, stackTrace) {
    print(error.code);
  });
}
