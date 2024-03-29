import 'package:cwrdm/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final databaseReference = FirebaseDatabase.instance.ref();

class Query {
  String title, description;
  late String id;
  late String auther;
  String reply = '';
  Query(this.title, this.description) {
    auther = currentUser!.uid;
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

void addQuery(Query query) {
  databaseReference.child('queries').child(query.id).set({
    'title': query.title,
    'description': query.description,
    'auther': query.auther,
    'reply': query.reply,
  });
  //add id to user as list
  databaseReference
      .child('users')
      .child(currentUser!.uid)
      .child('queries')
      .child(query.id)
      .set(true);
}

Future<List<Query>> getUserQueries() async {
  List<Query> queries = [];
  queries = await databaseReference
      .child('users')
      .child(currentUser!.uid)
      .child('queries')
      .once()
      .then((DatabaseEvent event) async {
    for (var element in event.snapshot.children) {
      await databaseReference
          .child('queries')
          .child(element.key!)
          .once()
          .then((DatabaseEvent event) {
        Query query = Query(event.snapshot.child('title').value.toString(),
            event.snapshot.child('description').value.toString());
        query.id = event.snapshot.key!;
        query.reply = event.snapshot.child('reply').value.toString();
        queries.add(query);
      });
    }
    return queries;
  });
  return queries;
}

void replyToQuery(String id, String reply) async {
  await databaseReference.child('queries').child(id).child('reply').set(reply);
  print('replied $reply');
}

Future<List<Query>> getAdminQueries() async {
  List<Query> queries = [];
  await databaseReference.child('queries').once().then((DatabaseEvent event) {
    for (var element in event.snapshot.children) {
      Query query = Query(element.child('title').value.toString(),
          element.child('description').value.toString());
      query.id = element.key!;
      query.auther = element.child('auther').value.toString();
      query.reply = element.child('reply').value.toString();
      if (query.reply.isEmpty) {
        queries.add(query);
      }
    }
  });
  return Future.value(queries);
}

void onQueryUpdated() async {
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
  databaseReference.child('queries').onChildChanged.listen((event) async {
    print(event.snapshot.value);
    if (event.snapshot.child('auther').value.toString() == currentUser!.uid) {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'reply',
        '...',
        actions: <AndroidNotificationAction>[
          //   AndroidNotificationAction('id_1', 'ok'),
        ],
      );
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(0, 'Got reply from Expert',
          event.snapshot.child('reply').value.toString(), notificationDetails);
    }
  });
}

Future<String> getUsername(String uid) async {
  String name = '';
  return databaseReference.child('users').child(uid).once().then((event) async {
    name = await event.snapshot.child('name').value.toString();
    return name;
  });
}

void onQueryAdded() async {
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

  databaseReference.child('queries').onChildAdded.listen((event) async {
    print(event.snapshot.value);
    if (currentUser!.email == adminEmail &&
        event.snapshot.child('reply').value.toString().isEmpty) {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'query',
        '...',
        actions: <AndroidNotificationAction>[
          //   AndroidNotificationAction('id_1', 'ok'),
        ],
      );
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      String username =
          await getUsername(event.snapshot.child('auther').value.toString());
      await flutterLocalNotificationsPlugin.show(0, 'New Query from $username',
          event.snapshot.child('title').value.toString(), notificationDetails);
    }
  });
}
