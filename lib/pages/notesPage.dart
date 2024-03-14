import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<String> notes = [
    'WATER Citizen Assessment Tool (WATER-CAT) is an initiative taken by KSCSTE-CWRDM under the project “Water for Change” to enable water sensitive governance in Kozhikode City through citizen engagement. The objective of the initiative is to disseminate the knowledge and skill to the citizen there by increase citizen Participation in water governance and empowering them. In the long run, the initiative will spread the message of need to assess the water quality, to keep our water resources clean and to conserve water resources, among the citizens at grass root level. This initiative will also play an instrumental role in improving the spatial and temporal availability of water data and enable implementation of better water management practices. The mobile app will be also acting as a water data bank for the city where common man can access the water data.',
    // Add more notes here
  ];
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: notes.length,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                width: 480, // Set the width of the card
                height: 500, // Set the height of the card
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About CWRDM and VISION of the APP',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          notes[index],
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_currentPage == notes.length - 1
            ? Icons.login
            : Icons.navigate_next),
        onPressed: () {
          if (_currentPage == notes.length - 1) {
            Navigator.pushReplacementNamed(context, '/signIn');
          } else {
            _pageController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          }
        },
      ),
    );
  }
}
