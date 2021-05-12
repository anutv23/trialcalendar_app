import 'package:calendar_app/datePicker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

import 'calendarDemo.dart';
import 'controllerpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: CalendarDemo(),
home: HomePage(),
 //home:TestPickerWidget(),
    );
  }
}



