import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events to note: "),
centerTitle: true,
        elevation: 6,

      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                helperMaxLines: 3,
                labelText: 'Event',
                hintText: 'Add an event',
                border: OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
