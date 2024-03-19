import 'package:cwrdm/database/service.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ViewAlert extends StatelessWidget {
  // Dummy list of alerts, replace with your actual data source

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
          future: getAlerts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Alerts Yet'))
                  : ListView.builder(
                    padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            margin: const EdgeInsets.all(10),
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description: ${snapshot.data![index]['message']!}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      'Date : ${snapshot.data![index]['date']!}'),
                                ],
                              ),
                            ));
                      },
                    );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
