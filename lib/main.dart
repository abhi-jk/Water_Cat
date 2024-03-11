import 'package:cwrdm/Authetication/RegistrationPage.dart';
import 'package:cwrdm/Authetication/SignInPage.dart';
import 'package:cwrdm/firebase_options.dart';
import 'package:cwrdm/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/signIn': (context) =>  SignInPage(),
        '/register': (context) => const RegistrationPage(),
        '/home': (context) => const Home(),
      },

      home:  SignInPage(),
    );
  }
}
