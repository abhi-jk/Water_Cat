import 'package:cwrdm/database/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              
              accountName: Text('Hi, ${user?.displayName ?? 'User Name'}'),
              accountEmail: Text(user?.email ?? 'user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  user?.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Projects Submitted'),
              onTap: () {
                Navigator.pushNamed(context, '/projectsSubmitted');
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark),
              title: Text('FAQ'),
              onTap: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Alerts'),
              onTap: () {
                Navigator.pushNamed(context, '/clientalert');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () {
                signOut(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Water Cat'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 90),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/cityInfo');
                },
                child: const Text('City Informations'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 90),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/citizen');
                },
                child: const Text('Citizens Portal'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 90),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/queryPage');
                },
                child: const Text('Connect with experts'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
