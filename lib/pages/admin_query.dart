import 'package:cwrdm/database/queries.dart';
import 'package:flutter/material.dart';

class AdminQueryPage extends StatefulWidget {
  const AdminQueryPage({super.key});

  @override
  State<AdminQueryPage> createState() => _AdminQueryPageState();
}

class _AdminQueryPageState extends State<AdminQueryPage> {
  List<Query> queries = [];

  void init() async {
    queries = await getAdminQueries();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Queries'),
        ),
        body: Center(
          child: Text('Queries here'),
        ));
  }
}
