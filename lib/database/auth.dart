import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../global.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Sign in with email and password
void testDB() {
  final ref = FirebaseDatabase.instance.ref();
  ref.child('test').set("Hello World");
}

Future<void> signInWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  //show laoding dialog
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  await _auth
      .signInWithEmailAndPassword(
    email: email,
    password: password,
  )
      .then((user) {
    Navigator.pop(context);
    if (user.user!.emailVerified) {
      currentUser = user.user;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Please verify your email'),
            action: SnackBarAction(
              label: 'Resend',
              onPressed: () {
                user.user!.sendEmailVerification();
              },
            )),
      );
    }
  }).onError<FirebaseException>((error, stackTrace) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.code),
      ),
    );
  });
}

Future<void> signOut(BuildContext context) async {
  await _auth.signOut().then((value) {
    //show snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign out successful'),
      ),
    );
    currentUser = null;
    Navigator.pushReplacementNamed(context, '/signIn');
  });
}

Future<void> resetPassword(String email, BuildContext context) async {
  await _auth.sendPasswordResetEmail(email: email).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: const Text('Reset password email has been sent'),
      ),
    );
  }).onError<FirebaseException>((error, stackTrace) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.code),
      ),
    );
  });
}

//add user to database with values name, email, adress(line1,line2,city,pincode) all are required parameters and show snackbar on error
Future<void> addUserToDatabase({
  required String name,
  required String email,
  required String line1,
  required String line2,
  required String city,
  required String pincode,
  required BuildContext context,
  required String password,
}) async {
  //show laoding dialog
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  await _auth
      .createUserWithEmailAndPassword(
    email: email,
    password: password,
  )
      .then((user) {
    user.user!.updateDisplayName(name);
    final ref = FirebaseDatabase.instance.ref().child('users');
    if (user != null) {
      ref.child(user.user!.uid).set({
        'name': name,
        'email': email,
        'line1': line1,
        'line2': line2,
        'city': city,
        'pincode': pincode,
      }).onError<FirebaseException>((error, stackTrace) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? "Error"),
          ),
        );
      });
    }
    user.user!.sendEmailVerification();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Success! Verification email has been sent'),
      ),
    );
    Navigator.pushReplacementNamed(context, '/notes');
  }).onError<FirebaseException>((error, stackTrace) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.code),
      ),
    );
  });
}
