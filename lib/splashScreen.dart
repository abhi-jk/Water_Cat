import 'package:cwrdm/global.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void init() {
    Future.delayed(const Duration(seconds: 3), () {
      navigateUser();
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  navigateUser() async {
    print('here');
    final FirebaseAuth auth = FirebaseAuth.instance;
    // bool isSignedIn = false;
    await auth.authStateChanges().listen((User? user) {
      currentUser = user;
     
      //  isSignedIn = true;
      //   print('User: ${user!.email}');
    });
//check for user login ;
    User? user = FirebaseAuth.instance.currentUser;
    currentUser = user;
    navigate();
  }

  void navigate() {
    if (currentUser == null) {
      Navigator.pushReplacementNamed(context, '/signIn');
    } else {
      print("User: ${currentUser!.email}  ");
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/images/Logo.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 137, 191, 235)),
            ),
            Expanded(
              child: Container(),
            ),
            const Text(
              'From',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'KSCSTE-CWRDM',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
