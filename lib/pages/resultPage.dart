import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final double pH;
  final double alkaline;
  final double hardness;
  final double chloride;
  final double tds;
  final double iron;
  final double ammonia;
  final double nitrate;
  final double resCl;

  ResultsPage({
    required this.pH,
    required this.alkaline,
    required this.hardness,
    required this.chloride,
    required this.tds,
    required this.iron,
    required this.ammonia,
    required this.nitrate,
    required this.resCl
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('pH'),
              subtitle: Text('User: $pH, Acceptable: (6.5-8.5)'),
              trailing: Icon(pH >= 6.5 && pH <= 8.5 ? Icons.check_circle : Icons.error, color: pH >= 6.5 && pH <= 8.5 ? Colors.green : Colors.red),
            ),
            ListTile(
              title: Text('Alkaline'),
              subtitle: Text('User: $alkaline, Acceptable: (200 mg/L)'),
              trailing: Icon(alkaline <= 200 ? Icons.check_circle : Icons.error, color: alkaline <= 200 ? Colors.green : Colors.red),
            ),
            ListTile(
              title: Text('Hardness'),
              subtitle: Text('User: $hardness, Acceptable: (200 mg/L)'),
              trailing: Icon(hardness <= 200 ? Icons.check_circle : Icons.error, color: hardness <= 200 ? Colors.green : Colors.red),
            ),
            ListTile(
              title: Text('Chloride'),
              subtitle: Text('User: $chloride, Acceptable: (250 mg/L)'),
              trailing: Icon(chloride <= 250 ? Icons.check_circle : Icons.error, color: chloride <= 250 ? Colors.green : Colors.red),
            ),
            ListTile(
              title: Text('TDS'),
              subtitle: Text('User: $tds, Acceptable: (500 mg/L)'),
              trailing: Icon(tds <= 500 ? Icons.check_circle : Icons.error, color: tds <= 500 ? Colors.green : Colors.red),
            ),
            ListTile(
              title: Text('Iron'),
              subtitle: Text('User: $iron, Acceptable: (1.0 mg/L)'),
              trailing: Icon(iron <= 1.0 ? Icons.check_circle : Icons.error, color: iron <= 1.0 ? Colors.green : Colors.red),
            ),
            ListTile(
              title: Text('Ammonia'),
              subtitle: Text('User: $ammonia, Acceptable: (0.5 mg/L)'),
              trailing: Icon(ammonia <= 0.5 ? Icons.check_circle : Icons.error, color: ammonia <= 0.5 ? Colors.green : Colors.red),
            ),
            ListTile(
              title: Text('Nitrate'),
              subtitle: Text('User: $nitrate, Acceptable: (45 mg/L)'),
              trailing: Icon(nitrate <= 45 ? Icons.check_circle : Icons.error, color: nitrate <= 45 ? Colors.green : Colors.red),
            ),
            ListTile(
              title: Text('Residual Chlorine'),
              subtitle: Text('User: $resCl, Acceptable: (Min 0.2 mg/L)'),
              trailing: Icon(resCl >= 0.2 ? Icons.check_circle : Icons.error, color: resCl >= 0.2 ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}