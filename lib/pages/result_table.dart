import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Table(
            
            border: TableBorder.all(),
            children:const [
              TableRow(children: [
                TableCell(child: Center(child: Text('Name'))),
                TableCell(child: Center(child: Text('Age'))),
                TableCell(child: Center(child: Text('Role'))),
              ]),
              TableRow(children: [
                TableCell(child: Center(child: Text('Alice'))),
                TableCell(child: Center(child: Text('25'))),
                TableCell(child: Center(child: Text('Developer'))),
              ]),
              TableRow(children: [
                TableCell(child: Center(child: Text('Bob'))),
                TableCell(child: Center(child: Text('30'))),
                TableCell(child: Center(child: Text('Designer'))),
              ]),
              TableRow(children: [
                TableCell(child: Center(child: Text('Charlie'))),
                TableCell(child: Center(child: Text('28'))),
                TableCell(child: Center(child: Text('Manager'))),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}