import 'package:flutter/material.dart';

class QueryPage extends StatefulWidget {
  QueryPage({Key? key}) : super(key: key);

  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Connect with Experts'),
        ),
        body: Center(
          child: Text('Your main content here'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.blue,
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Heading',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a heading';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 40),
                          Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.blue,
                            ),
                            child: TextFormField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Query',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your query';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 145, 101, 142),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
