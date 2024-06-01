import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CitizenPortalPage extends StatefulWidget {
  CitizenPortalPage({Key? key}) : super(key: key);

  @override
  _CitizenPortalPageState createState() => _CitizenPortalPageState();
}

class _CitizenPortalPageState extends State<CitizenPortalPage> {
  Future<void> showNoteOnce() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShownNote = prefs.getBool('hasShownNote') ?? false;

    if (!hasShownNote) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Note'),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('PARAMETER')),
                DataColumn(label: Text('pH')),
                DataColumn(label: Text('Alkalinity mg/l')),
                DataColumn(label: Text('Hardness mg/l')),
                DataColumn(label: Text('Chloride mg/l')),
                DataColumn(label: Text('TDS mg/l')),
                DataColumn(label: Text('Iron mg/l')),
                DataColumn(label: Text('Ammonia mg/l')),
                DataColumn(label: Text('Nitrate mg/l')),
                DataColumn(label: Text('Residual Chlorine mg/l')),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('ACCEPTABLE LIMIT')),
                    DataCell(Text('(6.5-8.5)')),
                    DataCell(Text('200 mg/L')),
                    DataCell(Text('200 mg/L')),
                    DataCell(Text('250 mg/l#')),
                    DataCell(Text('500mg/l')),
                    DataCell(Text('1.0mg/l')),
                    DataCell(Text('0.5 mg/l')),
                    DataCell(Text('45 mg/l#')),
                    DataCell(Text('Min 0.2mg/l')),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Swipe right to see more details',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          letterSpacing: 0.5)),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    //make the button stylish
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 122, 178, 224),
                      disabledForegroundColor: Colors.grey.withOpacity(0.38),
                    ),
                    child: Text('OK',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      await prefs.setBool('hasShownNote', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citizens Portal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    minimumSize: Size(double.infinity, 100)),
                onPressed: () async {
                  Navigator.pushNamed(context, '/project');
                  await showNoteOnce();
                },
                child: const Text(
                  'Water Quality Analysis',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                  minimumSize: Size(double.infinity, 100),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/citizenObservation');
                },
                child: const Text(
                  'Citizens Observation Portal',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
