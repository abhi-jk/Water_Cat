import 'package:cwrdm/database/project.dart';
import 'package:cwrdm/database/queries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminQueryPage extends StatefulWidget {
  const AdminQueryPage({super.key});

  @override
  State<AdminQueryPage> createState() => _AdminQueryPageState();
}

class _AdminQueryPageState extends State<AdminQueryPage> {
  List<Query> queries = [];

  void init() async {
    await getAdminQueries().then((value) {
      queries = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  TextEditingController replyController = TextEditingController();
  Widget build(BuildContext context) {
    getUnapprovedProjects();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Queries'),
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
            ? const Center(child: Text('No Queries Yet'))
            : ListView.builder(
                itemCount: queries.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    child: ExpansionTile(
                      title: Text(queries[index].title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Description:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(queries[index].description,
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.reply, color: Colors.white),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // Rounded corners
                                      ),
                                      title: const Center(
                                        child: Text(
                                          'Reply to Query',
                                          style: TextStyle(
                                            color:
                                                Colors.blue, // Change the color
                                            fontWeight:
                                                FontWeight.bold, // Make it bold
                                          ),
                                        ),
                                      ),
                                      content: TextField(
                                        controller: replyController,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          hintText: "Enter your reply here",
                                          border: OutlineInputBorder(
                                            // Add a border
                                            borderRadius: BorderRadius.circular(
                                                15), // Rounded corners
                                          ),
                                          fillColor: Colors.grey[
                                              200], // Change the fill color
                                          filled: true,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Center(
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(Colors
                                                      .blue), // Change the background color
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // Rounded corners
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              replyToQuery(queries[index].id,
                                                  replyController.text);
                                              Navigator.of(context).pop();
                                              queries.removeAt(index);
                                              setState(() {});
                                            },
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                color: Colors
                                                    .white, // Change the color
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: const Text('Reply:',
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
    );
  }
}
