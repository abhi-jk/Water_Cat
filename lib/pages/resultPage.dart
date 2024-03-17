import 'package:cwrdm/database/project.dart';
import 'package:flutter/material.dart';


class ResultsPage extends StatelessWidget {
  final Project project;

  const ResultsPage({
    required this.project,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Result(),
      ),
    );
  }

  ListView Result() {
    return ListView(
        children: <Widget>[
          ListTile(
            title: const Text('pH'),
            subtitle: Text('User: ${project.pH}, Acceptable: (6.5-8.5)'),
            trailing: Icon(
                double.parse(project.pH) >= 6.5 &&
                        double.parse(project.pH) <= 8.5
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.pH) >= 6.5 &&
                        double.parse(project.pH) <= 8.5
                    ? Colors.green
                    : Colors.red),
          ),
          ListTile(
            title: const Text('Alkaline'),
            subtitle:
                Text('User: ${project.alkaline}, Acceptable: (200 mg/L)'),
            trailing: Icon(
                double.parse(project.alkaline) <= 200
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.alkaline) <= 200
                    ? Colors.green
                    : Colors.red),
          ),
          ListTile(
            title: const Text('Hardness'),
            subtitle:
                Text('User: ${project.hardness}, Acceptable: (200 mg/L)'),
            trailing: Icon(
                double.parse(project.hardness) <= 200
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.hardness) <= 200
                    ? Colors.green
                    : Colors.red),
          ),
          ListTile(
            title: const Text('Chloride'),
            subtitle:
                Text('User: ${project.chloride}, Acceptable: (250 mg/L)'),
            trailing: Icon(
                double.parse(project.chloride) <= 250
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.chloride) <= 250
                    ? Colors.green
                    : Colors.red),
          ),
          ListTile(
            title: const Text('TDS'),
            subtitle: Text('User: ${project.tds}, Acceptable: (500 mg/L)'),
            trailing: Icon(
                double.parse(project.tds) <= 500
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.tds) <= 500
                    ? Colors.green
                    : Colors.red),
          ),
          ListTile(
            title: const Text('Iron'),
            subtitle: Text('User: ${project.iron}, Acceptable: (1.0 mg/L)'),
            trailing: Icon(
                double.parse(project.iron) <= 1.0
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.iron) <= 1.0
                    ? Colors.green
                    : Colors.red),
          ),
          ListTile(
            title: const Text('Ammonia'),
            subtitle:
                Text('User: ${project.ammonia}, Acceptable: (0.5 mg/L)'),
            trailing: Icon(
                double.parse(project.ammonia) <= 0.5
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.ammonia) <= 0.5
                    ? Colors.green
                    : Colors.red),
          ),
          ListTile(
            title: const Text('Nitrate'),
            subtitle: Text('User: ${project.nitrate}, Acceptable: (45 mg/L)'),
            trailing: Icon(
                double.parse(project.nitrate) <= 45
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.nitrate) <= 45
                    ? Colors.green
                    : Colors.red),
          ),
          ListTile(
            title: const Text('Residual Chlorine'),
            subtitle:
                Text('User: ${project.resCl}, Acceptable: (Min 0.2 mg/L)'),
            trailing: Icon(
                double.parse(project.resCl) >= 0.2
                    ? Icons.check_circle
                    : Icons.error,
                color: double.parse(project.resCl) >= 0.2
                    ? Colors.green
                    : Colors.red),
          ),
          if (project.isApproved == 'true')
            ElevatedButton(
                onPressed: () {
                  
                },
                child: Text('Download PDF'))
        ],
      );
  }
}
