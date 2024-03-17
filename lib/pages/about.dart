import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'About Water Cat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Water Cat is an application designed to help users track their water consumption. '
              'It provides a simple and intuitive interface for users to log their daily water intake and view their hydration history. '
              'The goal of Water Cat is to encourage healthy hydration habits and promote overall wellness.',
            ),
          ],
        ),
      ),
    );
  }
}
