
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDemo extends StatefulWidget {
  @override
  _CalendarDemoState createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<CalendarDemo> {
  DateTime dateTime = DateTime.now();
  DateTime enddateTime = DateTime.now();
  bool pressed=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: Text("Calendar Display"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Meeting Type:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MeetingType(),
                ],
              ),
            ),
            Text(
              "Start Time:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Container(
                height: 100,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: dateTime,
                  onDateTimeChanged: (dateTime) {

                    setState(() => this.dateTime = dateTime);
                    final value =
                    DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
                    displayTime(value);

                  },
                  use24hFormat: false,
                  minuteInterval: 1,
                )),



            Text(
              "End Time:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
                height: 100,
                child: CupertinoDatePicker(

                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: enddateTime,
                  onDateTimeChanged: (enddateTime) {
                    setState(() {
                      pressed = true;
                      final value2 = enddateTime;
                      // this.enddateTime = enddateTime;
                      // final value2 =
                      // DateFormat('MM/dd/yyyy HH:mm').format(enddateTime);
                      //displayTime(value2);
                      pressed?displayTime(value2):Text("not selected");
                    });
                  },
                  use24hFormat: false,
                  minuteInterval: 1,
                )),
            //  pressed?displayTime(value2):SizedBox(),

            SizedBox(height: 40,),
            ElevatedButton(
                child: Text("Confirm Time"),

                onPressed: (){
                  showDialog(context: context,
                      builder: (_) => AlertDialog(
                        title: Text("The meeting scheduled time and date is :"),
                        content: Text('${dateTime.month} / ${dateTime.day} at ${dateTime.hour}:${dateTime.minute} to ${enddateTime.hour}:${enddateTime.minute} '),
                      ));
                })
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: _showAddDialog,
      // ),
    );
  }


// _showAddDialog() {
//   showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         child: Container(
//           height: 400,
//           width: 300,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 10.0, vertical: 5),
//                 child: TextFormField(
//
//                   decoration: InputDecoration(
//                     // focusColor: Colors.black,
//                     labelText: 'Meeting Appointment',
//                     // hintText: 'Enter the title',
//                   ),
//                 ),
//               ),
//
//               Container(
//                 height: 200,
//                 child: CupertinoDatePicker(
//                   mode: CupertinoDatePickerMode.dateAndTime,
//                   initialDateTime: DateTime.now(),
//                   onDateTimeChanged: (DateTime newDateTime) {
//                     //Do Some thing
//                   },
//
//                   use24hFormat: false,
//                   minuteInterval: 1,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: Container(
//                   height: 30,
//                   width: 70,
//                   decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius:
//                       BorderRadius.circular(19)),
//                   child: TextButton(
//                     onPressed: () {
//
//                     },
//                     child: Text(
//                       "Add",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ));
// }
}
Widget displayTime(value) {
  return Center(
    child:Container(
        color: Colors.red,
        height: 100,
        width: 200,
        child: Text("Selected Time is : $value")),
  );
}

class MeetingType extends StatefulWidget {
  const MeetingType({Key key}) : super(key: key);

  @override
  _MeetingTypeState createState() => _MeetingTypeState();
}

class _MeetingTypeState extends State<MeetingType> {
  String _value;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            child: Text('Item 1'),
            value: 'one',
          ),
          DropdownMenuItem<String>(
            child: Text('Item 2'),
            value: 'two',
          ),
        ],
        onChanged: (String value) {
          setState(() {
            _value = value;
          });
        },
        hint: Text('Select Type:'),
        value: _value,
      ),
    );
  }
}
