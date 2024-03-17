import 'package:cwrdm/Authetication/RegistrationPage.dart';
import 'package:cwrdm/Authetication/SignInPage.dart';
import 'package:cwrdm/Authetication/admin.dart';
import 'package:cwrdm/database/queries.dart';
import 'package:cwrdm/firebase_options.dart';
import 'package:cwrdm/pages/FaqPage.dart';
import 'package:cwrdm/pages/admin.dart';
import 'package:cwrdm/pages/admin_query.dart';
import 'package:cwrdm/pages/citizen_observation_portal.dart';
import 'package:cwrdm/pages/citizens_portal.dart';
import 'package:cwrdm/pages/city_info.dart';
import 'package:cwrdm/pages/home.dart';
import 'package:cwrdm/pages/new_project.dart';
import 'package:cwrdm/pages/notesPage.dart';
import 'package:cwrdm/pages/queryPage.dart';
import 'package:cwrdm/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WATER CAT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
            bodyText1: TextStyle(fontFamily: 'Montserrat'),
            bodyText2: TextStyle(fontFamily: 'Montserrat'),
      ),
      ),
      routes: {
        '/faq': (context) => FaqPage(),
        '/citizenObservation': (context) => CitizensObservationPortal(),
        '/project': (context) => const NewProjectPage(),
        '/notes': (context) => NotesPage(),
        '/queryPage': (context) => QueryPage(),
        '/citizen': (context) => CitizenPortalPage(),
        '/cityInfo': (context) => CityInfoPage(),
        '/signIn': (context) => const SignInPage(),
        '/admin': (context) => const AdminLogin(),
        '/register': (context) => const RegistrationPage(),
        '/home': (context) => const Home(),
        '/splash': (context) => SplashScreen(),
        '/adminPage': (context) => AdminPage(),
        '/adminQuery': (context) => AdminQueryPage(),
      },
      initialRoute: '/splash',
    );
  }
}
