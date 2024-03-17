import 'package:cwrdm/database/queries.dart';
import 'package:flutter/material.dart';

class QueryPage extends StatefulWidget {
  QueryPage({Key? key}) : super(key: key);

  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  final key = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Query> queries = [];
  void init() async {
    await getUserQueries().then((value) => setState(() {
          queries = value;
        }));
    print(queries);
    //setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect with Experts'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getAdminQueries().then((value) {
            queries = value;
            print(queries);
            setState(() {});
          });
        },
        child: queries.isEmpty
            ? Center(child: Text('No Queries Yet'))
            : ListView.builder(
                itemCount: queries.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: ExpansionTile(
                      title: Text(queries[index].title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Description:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(queries[index].description,
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      trailing: queries[index].reply.isEmpty
                          ? Chip(
                              label: Text('Pending',
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.orange)
                          : Chip(
                              label: Text('Replied',
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green),
                      children: <Widget>[
                        ListTile(
                          title: Text('Reply:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: Text(queries[index].reply.isEmpty
                              ? 'No reply yet'
                              : queries[index].reply),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          getUserQueries();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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
                              controller: _titleController,
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
                              controller: _descriptionController,
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Query query = Query(_titleController.text,
                                      _descriptionController.text);
                                  //add query to database
                                  addQuery(query);
                                  queries.add(query);
                                  Navigator.pop(context);
                                  //show snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Query Submitted'),
                                    ),
                                  );
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
