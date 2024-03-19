import 'dart:io';
import 'package:cwrdm/global.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<String> getUserName(String id) {
  //get user name using ID
  final ref = FirebaseDatabase.instance.ref().child('users').child(id);
  return ref.once().then((value) {
    return value.snapshot.child('name').value.toString();
  });
}

Future reportIssue(
    {required String description,
    required String loc,
    required File image,
    required BuildContext context}) async {
  //show loading dialog
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = FirebaseStorage.instance
      .ref()
      .child('issue_images')
      .child(currentUser!.uid)
      .child(id);
  await ref.putFile(image);
  final url = await ref.getDownloadURL();
  final dbRef = FirebaseDatabase.instance.ref().child('issues').child(id);
  dbRef.set({
    'description': description,
    'location': loc,
    'image': url,
    'author': currentUser!.uid,
    'date': //date in format dd-mm-yyyy
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
  });
  //add issue to the user
  final userRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('issues');
  //push as array
  userRef.child(id).set(id).whenComplete(() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Issue reported successfully')));
  });

  //close loading dialog
  Navigator.pop(context);
}

Future<List<Map<String, String>>> getUserIssues() async {
  List<Map<String, String>> list = [];
  await FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('issues')
      .once()
      .then((value) {
    value.snapshot.children.forEach((element) async {
      await FirebaseDatabase.instance
          .ref()
          .child('issues')
          .child(element.child('issue_id').value.toString())
          .once()
          .then((value) {
        list.add({
          'description': value.snapshot.child('description').value.toString(),
          'location': value.snapshot.child('location').value.toString(),
          'image': value.snapshot.child('image').value.toString(),
          'date': value.snapshot.child('date').value.toString()
        });
      });
    });
  });
  return list;
}

Future<List<Map<String, String>>> getAdminIssues() async {
  List<Map<String, String>> list = [];

  return await FirebaseDatabase.instance
      .ref()
      .child('issues')
      .once()
      .then((value) async {
    for (DataSnapshot element in value.snapshot.children) {
      String name = await getUserName(element.child('author').value.toString());
      list.add(
        {
          'description': element.child('description').value.toString(),
          'location': element.child('location').value.toString(),
          'image': element.child('image').value.toString(),
          'date': element.child('date').value.toString(),
          'auther': name
        },
      );
    }
    print(list);
    return list;
  });
}

Future reportBiodiversity(
    {required String description,
    required String loc,
    required File image,
    required BuildContext context}) async {
  //show loading dialog
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = FirebaseStorage.instance
      .ref()
      .child('biodiversity_images')
      .child(currentUser!.uid)
      .child(id);
  await ref.putFile(image);
  final url = await ref.getDownloadURL();
  final dbRef = FirebaseDatabase.instance.ref().child('biodiversity').child(id);
  dbRef.set({
    'description': description,
    'location': loc,
    'image': url,
    'author': currentUser!.uid,
    'date': //date in format dd-mm-yyyy
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
  });
  //add issue to the user
  final userRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('biodiversity');
  //push as array
  userRef.child(id).set(id).whenComplete(() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biodiversity reported successfully')));
  });

  //close loading dialog
  Navigator.pop(context);
}

Future<List<Map<String, String>>> getUserBioDiversity() async {
  List<Map<String, String>> list = [];
  await FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('biodiversity')
      .once()
      .then((value) {
    value.snapshot.children.forEach((element) async {
      await FirebaseDatabase.instance
          .ref()
          .child('biodiversity')
          .child(element.child('biodiversity_id').value.toString())
          .once()
          .then((value) {
        list.add({
          'description': value.snapshot.child('description').value.toString(),
          'location': value.snapshot.child('location').value.toString(),
          'image': value.snapshot.child('image').value.toString(),
          'date': value.snapshot.child('date').value.toString()
        });
      });
    });
  });
  return list;
}

Future<List<Map<String, String>>> getAdminBioDiversity() async {
  List<Map<String, String>> list = [];

  return await FirebaseDatabase.instance
      .ref()
      .child('biodiversity')
      .once()
      .then((value) async {
    for (DataSnapshot element in value.snapshot.children) {
      String name = await getUserName(element.child('author').value.toString());
      // print('name is $name');
      list.add(
        {
          'description': element.child('description').value.toString(),
          'location': element.child('location').value.toString(),
          'image': element.child('image').value.toString(),
          'date': element.child('date').value.toString(),
          'author': name
        },
      );
    }
    print(list);
    return list;
  });
}

Future reportFloodLevel(
    {required String description,
    required String loc,
    required File image,
    required BuildContext context}) async {
  //show loading dialog
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = FirebaseStorage.instance
      .ref()
      .child('floodlevel_images')
      .child(currentUser!.uid)
      .child(id);
  await ref.putFile(image);
  final url = await ref.getDownloadURL();
  final dbRef = FirebaseDatabase.instance.ref().child('floodlevel').child(id);
  dbRef.set({
    'description': description,
    'location': loc,
    'image': url,
    'author': currentUser!.uid,
    'date': //date in format dd-mm-yyyy
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
  });
  //add issue to the user
  final userRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('floodlevel');
  //push as array
  userRef.child(id).set(id).whenComplete(() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Flood level reported successfully')));
  });

  //close loading dialog
  Navigator.pop(context);
}

Future<List<Map<String, String>>> getUserFloodLevels() async {
  List<Map<String, String>> list = [];
  await FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('floodlevel')
      .once()
      .then((value) {
    value.snapshot.children.forEach((element) async {
      await FirebaseDatabase.instance
          .ref()
          .child('floodlevel')
          .child(element.child('floodlevel_id').value.toString())
          .once()
          .then((value) {
        list.add({
          'description': value.snapshot.child('description').value.toString(),
          'location': value.snapshot.child('location').value.toString(),
          'image': value.snapshot.child('image').value.toString(),
          'date': value.snapshot.child('date').value.toString()
        });
      });
    });
  });
  return list;
}

Future<List<Map<String, String>>> getAdminFloodLevels() async {
  List<Map<String, String>> list = [];

  return await FirebaseDatabase.instance
      .ref()
      .child('floodlevel')
      .once()
      .then((value) async {
    for (DataSnapshot element in value.snapshot.children) {
      String name = await getUserName(element.child('author').value.toString());
      list.add(
        {
          'description': element.child('description').value.toString(),
          'location': element.child('location').value.toString(),
          'image': element.child('image').value.toString(),
          'date': element.child('date').value.toString(),
          'author': name
        },
      );
    }
    print(list);
    return list;
  });
}

Future reportGroundWaterLevel(
    {required String description,
    required String loc,
    required BuildContext context}) async {
  //show loading dialog
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  final dbRef =
      FirebaseDatabase.instance.ref().child('groundwaterlevel').child(id);
  dbRef.set({
    'description': description,
    'location': loc,
    'author': currentUser!.uid,
    'date': //date in format dd-mm-yyyy
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
  });
  //add issue to the user
  final userRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('groundwaterlevel');
  //push as array
  userRef.child(id).set(id).whenComplete(() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Groundwater level reported successfully')));
  });

  //close loading dialog
  Navigator.pop(context);
}

Future<List<Map<String, String>>> getUserGroundWaterLevels() async {
  List<Map<String, String>> list = [];
  await FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('groundwaterlevel')
      .once()
      .then((value) {
    value.snapshot.children.forEach((element) async {
      await FirebaseDatabase.instance
          .ref()
          .child('groundwaterlevel')
          .child(element.child('groundwaterlevel_id').value.toString())
          .once()
          .then((value) {
        list.add({
          'description': value.snapshot.child('description').value.toString(),
          'location': value.snapshot.child('location').value.toString(),
          'image': value.snapshot.child('image').value.toString(),
          'date': value.snapshot.child('date').value.toString()
        });
      });
    });
  });
  return list;
}

Future<List<Map<String, String>>> getAdminGroundWaterLevels() async {
  List<Map<String, String>> list = [];

  return await FirebaseDatabase.instance
      .ref()
      .child('groundwaterlevel')
      .once()
      .then((value) async {
    for (DataSnapshot element in value.snapshot.children) {
      String name = await getUserName(element.child('author').value.toString());
      list.add(
        {
          'description': element.child('description').value.toString(),
          'location': element.child('location').value.toString(),
          'image': element.child('image').value.toString(),
          'date': element.child('date').value.toString(),
          'author': name
        },
      );
    }
    print(list);
    return list;
  });
}

Future reportRainfall(
    {required String description,
    required String loc,
    required BuildContext context}) async {
  //show loading dialog
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  final dbRef = FirebaseDatabase.instance.ref().child('rainfall').child(id);
  dbRef.set({
    'description': description,
    'location': loc,
    'author': currentUser!.uid,
    'date': //date in format dd-mm-yyyy
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
  });
  //add issue to the user
  final userRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('rainfall');
  //push as array
  userRef.child(id).set(id).whenComplete(() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rainfall reported successfully')));
  });

  //close loading dialog
  Navigator.pop(context);
}

Future<List<Map<String, String>>> getUserRainfall() async {
  List<Map<String, String>> list = [];
  await FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(currentUser!.uid)
      .child('rainfall')
      .once()
      .then((value) {
    value.snapshot.children.forEach((element) async {
      await FirebaseDatabase.instance
          .ref()
          .child('rainfall')
          .child(element.child('rainfall_id').value.toString())
          .once()
          .then((value) {
        list.add({
          'description': value.snapshot.child('description').value.toString(),
          'location': value.snapshot.child('location').value.toString(),
          'image': value.snapshot.child('image').value.toString(),
          'date': value.snapshot.child('date').value.toString()
        });
      });
    });
  });
  return list;
}

Future<List<Map<String, String>>> getAdminRainfall() async {
  List<Map<String, String>> list = [];

  return await FirebaseDatabase.instance
      .ref()
      .child('rainfall')
      .once()
      .then((value) async {
    for (DataSnapshot element in value.snapshot.children) {
      String name = await getUserName(element.child('author').value.toString());
      list.add(
        {
          'description': element.child('description').value.toString(),
          'location': element.child('location').value.toString(),
          'image': element.child('image').value.toString(),
          'date': element.child('date').value.toString(),
          'author': name
        },
      );
    }
    print(list);
    return list;
  });
}

Future sendAlert(String msg, BuildContext context) async {
  final ref = FirebaseDatabase.instance.ref().child('alerts');
  ref.push().set({
    'message': msg,
    'date': //date in format dd-mm-yyyy
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
  }).then((value) => ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Alert sent successfully'))));
}

Future<List<Map<String, String>>> getAlerts() async {
  List<Map<String, String>> list = [];

  return await FirebaseDatabase.instance
      .ref()
      .child('alerts')
      .once()
      .then((value) async {
    for (DataSnapshot element in value.snapshot.children) {
      list.add(
        {
          'message': element.child('message').value.toString(),
          'date': element.child('date').value.toString(),
        },
      );
    }
    print(list);
    return list;
  });
}

void onAlert() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
    //dismiss notification
    await flutterLocalNotificationsPlugin.cancel(0);
  });
  //listen for changes in the alerts and show notification
  FirebaseDatabase.instance.ref().child('alerts').onChildAdded.listen((event) {
    print(event.snapshot.value);
    //show notification
    flutterLocalNotificationsPlugin.show(
        0,
        'Alert',
        event.snapshot.child('message').value.toString(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ));
  });

}
